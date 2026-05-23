export function validateTodo(input) {
  const errors = {};

  if (!input.title?.trim()) {
    errors.title = "Title is required";
  }

  if (input.title && input.title.length > 10) {
    errors.title = "タイトルは10文字まで";
  }

  if (input.detail && input.detail.length > 50) {
    errors.detail = "詳細は50文字まで";
  }

  if (input.dueDate) {
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    const d = new Date(input.dueDate);

    console.log(`validate: input.dueDate: ${input.dueDate}`);

    if (d < today) {
      console.log(`今日以降の日付を指定してください: ${input.dueDate}`);
      errors.dueDate = "今日以降の日付を指定してください";
    }
  }

  console.log(`validate: input.priority: ${input.priority}`);
  if (!["low", "medium", "high"].includes(input.priority)) {
    errors.priority = "優先度を選択してください";
  }

  return errors;
}
