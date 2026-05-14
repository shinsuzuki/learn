const express = require("express");
const cors = require("cors");
const sqlite3 = require("sqlite3").verbose();
const { open } = require("sqlite");

const app = express();
// ポートリトライ設定
const START_PORT = 3001; // 開始ポート
const MAX_PORT = 3011;   // 最大ポート

app.use(cors());
app.use(express.json());

let db;

const initialNotes = [
  {
    title: "コードの品質について",
    content:
      "「どんなバカでも、コンピューターが理解できるコードは書ける。優れたプログラマーは、人間が理解できるコードを書く。」",
  },
  {
    title: "完璧を求めることについて",
    content:
      "「完璧を達成するのは、付け加えるものが何もなくなった時ではなく、取り除くものが何もなくなった時である。」",
  },
  {
    title: "デバッグの本質",
    content:
      "「デバッグは、最初にコードを書く時の2倍は難しい。だから、コードを書く時に賢さを限界まで使ったなら、デバッグする時には力不足だ。」",
  },
  {
    title: "エラーハンドリングの重要性",
    content:
      "「エラーは何も言わずに過ぎ去ってはいけない。明示的に黙らされていない限りは。」",
  },
  {
    title: "単純さの価値",
    content: "「単純さは究極の洗練である。」 ",
  },
  {
    title: "プログラマーの心得",
    content:
      "「優れたプログラマーになるための最も重要な特質は、自分のミスを認める能力である。」 - ブルックス",
  },
  {
    title: "コードレビューについて",
    content:
      "「コードレビューは、バグを見つけるためだけでなく、知識を共有し、より良いコードを書く方法を学ぶためにある。」",
  },
  {
    title: "継続的改善",
    content:
      "「ソフトウェアは庭のようなものだ。継続的に手入れをしなければ、雑草が生い茂ってしまう。」",
  },
  {
    title: "チームワークの重要性",
    content:
      "「一人では何もできない。しかし、みんなで力を合わせれば、驚くべきことができる。」",
  },
  {
    title: "学び続けることの大切さ",
    content:
      "「プログラミングの世界では、学習を止めた瞬間から、あなたは時代遅れになり始める。技術は常に進化している。」",
  },
];

async function insertInitialData(db) {
  // テーブルの作成
  await db.exec(`
    CREATE TABLE notes (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      content TEXT NOT NULL,
      createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
      updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
    )
  `);

  console.log("初期データを挿入しています...");

  for (const note of initialNotes) {
    await db.run("INSERT INTO notes (title, content) VALUES (?, ?)", [
      note.title,
      note.content,
    ]);
  }

  console.log(`初期データ ${initialNotes.length} 件を挿入しました`);
}

async function initializeDb() {
  try {
    console.log("データベースに接続しています...");
    db = await open({
      filename: "./database.sqlite",
      driver: sqlite3.Database,
    });
    console.log("データベース接続が確立されました");

    // テーブルの存在確認
    const tableExists = await db.get(`
      SELECT name FROM sqlite_master 
      WHERE type='table' AND name='notes'
    `);

    if (!tableExists) {
      console.log("データベースを初期化しています...");
      // 初期データの挿入（テーブル作成も含む）
      await insertInitialData(db);
      console.log("データベースが初期化されました");
    } else {
      console.log("既存のデータベースを使用します");
    }
  } catch (error) {
    console.error("データベースの初期化に失敗しました:", error);
    throw error;
  }
}

app.get("/notes", async (req, res) => {
  try {
    const page = parseInt(req.query.page) || 1;
    const limit = parseInt(req.query.limit) || 9;
    const search = req.query.search || "";
    const offset = (page - 1) * limit;

    let notesQuery = "SELECT * FROM notes";
    let countQuery = "SELECT COUNT(*) as total FROM notes";
    let queryParams = [];

    if (search) {
      const searchCondition = " WHERE title LIKE ? OR content LIKE ?";
      notesQuery += searchCondition;
      countQuery += searchCondition;
      const searchParam = `%${search}%`;
      queryParams = [searchParam, searchParam];
    }

    notesQuery += " ORDER BY updatedAt DESC LIMIT ? OFFSET ?";
    queryParams.push(limit, offset);

    const notes = await db.all(notesQuery, queryParams);
    const countResult = await db.get(
      countQuery,
      search ? [`%${search}%`, `%${search}%`] : []
    );

    const totalItems = countResult.total;
    const totalPages = Math.ceil(totalItems / limit);

    res.json({
      notes,
      pagination: {
        currentPage: page,
        totalPages: totalPages,
      },
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

app.get("/notes/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const note = await db.get("SELECT * FROM notes WHERE id = ?", id);

    if (!note) {
      return res.status(404).json({ error: "Note not found" });
    }

    res.json(note);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

app.post("/notes", async (req, res) => {
  try {
    console.log("POST /notes - リクエストボディ:", req.body);
    const { title, content } = req.body;

    if (!title || !content) {
      console.log("タイトルまたは内容が不足しています");
      return res.status(400).json({ error: "Title and content are required" });
    }

    if (!db) {
      console.error("データベースが初期化されていません");
      return res.status(500).json({ error: "Database not available" });
    }

    console.log("ノートを作成しています:", { title, content });
    const result = await db.run(
      "INSERT INTO notes (title, content) VALUES (?, ?)",
      [title, content]
    );
    console.log("作成結果:", result);

    const newNote = await db.get(
      "SELECT * FROM notes WHERE id = ?",
      result.lastID
    );
    console.log("作成されたノート:", newNote);
    res.status(201).json(newNote);
  } catch (error) {
    console.error("ノート作成エラー:", error);
    res
      .status(500)
      .json({ error: "Internal Server Error", details: error.message });
  }
});

app.put("/notes/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const { title, content } = req.body;

    // 既存のノートを取得
    const existingNote = await db.get("SELECT * FROM notes WHERE id = ?", id);
    if (!existingNote) {
      return res.status(404).json({ error: "Note not found" });
    }

    // 送信されていないフィールドには既存の値を使用
    const updatedTitle = title ? title : existingNote.title;
    const updatedContent = content ? content : existingNote.content;
    const result = await db.run(
      "UPDATE notes SET title = ?, content = ?, updatedAt = CURRENT_TIMESTAMP WHERE id = ?",
      [updatedTitle, updatedContent, id]
    );

    const updatedNote = await db.get("SELECT * FROM notes WHERE id = ?", id);
    res.json(updatedNote);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

app.delete("/notes/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const result = await db.run("DELETE FROM notes WHERE id = ?", id);

    if (result.changes === 0) {
      return res.status(404).json({ error: "Note not found" });
    }

    res.json({ success: true });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

// 指定されたポートでサーバー起動を試みる
function tryPort(port) {
  return new Promise((resolve, reject) => {
    const server = app.listen(port)
      .on('listening', () => {
        console.log(`サーバーが http://localhost:${port} で起動しています`);
        resolve(server);
      })
      .on('error', (error) => {
        if (error.code === 'EADDRINUSE') {
          reject(error);
        } else {
          console.error(`ポート ${port} でエラーが発生しました:`, error);
          reject(error);
        }
      });
  });
}

// ポート3001から3011まで順番に試行してサーバーを起動
async function startServer() {
  for (let port = START_PORT; port <= MAX_PORT; port++) {
    try {
      console.log(`ポート ${port} で起動を試みています...`);
      await tryPort(port);
      return;
    } catch (error) {
      if (error.code === 'EADDRINUSE') {
        console.log(`ポート ${port} は既に使用されています`);
        if (port === MAX_PORT) {
          console.error(`\nエラー: ポート ${START_PORT} から ${MAX_PORT} まですべて使用中です`);
          console.error('他のアプリケーションを停止してから再度お試しください');
          process.exit(1);
        }
        continue;
      } else {
        console.error('予期しないエラーが発生しました:', error);
        process.exit(1);
      }
    }
  }
}

// データベース初期化後にサーバー起動
initializeDb()
  .then(() => {
    startServer();
  })
  .catch((error) => {
    console.error("データベースの初期化に失敗しました:", error);
    process.exit(1);
  });
