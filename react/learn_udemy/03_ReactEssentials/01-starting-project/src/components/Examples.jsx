import { useState } from "react";
import { EXAMPLES } from "@/data.js";
import TabButton from "@/components/TabButton.jsx";
import Section from "@/components/Section.jsx";
import Tabs from "@/components/Tabs.jsx";

export default function Examples() {
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
    <>
      <Section title="Examples" id="examples">
        <Tabs
          buttons={
            <>
              <TabButton isSelected={selectedTopic === "components"} onClick={() => handlerSelect("components")}>
                Components
              </TabButton>
              <TabButton isSelected={selectedTopic === "jsx"} onClick={() => handlerSelect("jsx")}>
                JSX
              </TabButton>
              <TabButton isSelected={selectedTopic === "props"} onClick={() => handlerSelect("props")}>
                Props
              </TabButton>
              <TabButton isSelected={selectedTopic === "state"} onClick={() => handlerSelect("state")}>
                State
              </TabButton>
            </>
          }
        >
          {tabContent}
        </Tabs>

        {/* <menu>
          <TabButton isSelected={selectedTopic === "components"} onClick={() => handlerSelect("components")}>
            Components
          </TabButton>
          <TabButton isSelected={selectedTopic === "jsx"} onClick={() => handlerSelect("jsx")}>
            JSX
          </TabButton>
          <TabButton isSelected={selectedTopic === "props"} onClick={() => handlerSelect("props")}>
            Props
          </TabButton>
          <TabButton isSelected={selectedTopic === "state"} onClick={() => handlerSelect("state")}>
            State
          </TabButton>
        </menu>
        {tabContent} */}
      </Section>
    </>
  );
}
