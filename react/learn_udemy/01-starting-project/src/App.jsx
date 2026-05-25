import { useState } from "react";
import Header from "@/components/Header/Header.jsx";
import CoreCocept from "@/components/CoreConcept.jsx";
import { CORE_CONCEPTS, EXAMPLES } from "@/data.js";
import TabButton from "@/components/TabButton.jsx";

function App() {
  const [selectedTopic, setSelectedTopic] = useState("");
  // let tabContent = "please click a button";

  function handlerSelect(selectedButton) {
    // console.log("hello select > " + selectedButton);
    // tabContent = selectedButton;
    setSelectedTopic(selectedButton);
  }

  let tabContent = <p>please select a tocpic.</p>;

  if (selectedTopic) {
    tabContent = (
      <div id="tab-content">
        <h3>{EXAMPLES[selectedTopic].title}</h3>
        <p>{EXAMPLES[selectedTopic].description}</p>
        <pre>
          <code>{EXAMPLES[selectedTopic].code}</code>
        </pre>
      </div>
    );
  }

  return (
    <div>
      <Header />
      <main>
        <h2>Core Concepts</h2>
        <section id="core-concepts">
          <ul>
            {CORE_CONCEPTS.map((concept) => (
              <CoreCocept
                key={concept.title}
                // title={concept.title}
                // description={concept.description}
                // image={concept.image}
                {...concept}
              />
            ))}
          </ul>
        </section>
        <section id="examples">
          <h2>Examples</h2>
          <menu>
            <TabButton isSelected={selectedTopic === "components"} onSelect={() => handlerSelect("components")}>
              Components
            </TabButton>
            <TabButton isSelected={selectedTopic === "jsx"} onSelect={() => handlerSelect("jsx")}>
              JSX
            </TabButton>
            <TabButton isSelected={selectedTopic === "props"} onSelect={() => handlerSelect("props")}>
              Props
            </TabButton>
            <TabButton isSelected={selectedTopic === "state"} onSelect={() => handlerSelect("state")}>
              State
            </TabButton>
          </menu>
          {tabContent}
        </section>
      </main>
    </div>
  );
}

export default App;
