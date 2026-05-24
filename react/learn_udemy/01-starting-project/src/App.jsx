import Header from "@/components/Header/Header.jsx";
import CoreCocept from "@/components/CoreConcept.jsx";
import { CORE_CONCEPTS } from "@/data.js";
import TabButton from "@/components/TabButton.jsx";

function App() {
  return (
    <div>
      <Header />
      <main>
        <h2>Core Concepts</h2>
        <section id="core-concepts">
          <ul>
            {CORE_CONCEPTS.map((concept) => (
              <CoreCocept title={concept.title} description={concept.description} image={concept.image} />
            ))}
          </ul>
        </section>
        <section id="examples">
          <h2>Examples</h2>
          <menu>
            <TabButton>Components</TabButton>
            <TabButton>JSX</TabButton>
            <TabButton>Props</TabButton>
            <TabButton>State</TabButton>
          </menu>
        </section>
      </main>
    </div>
  );
}

export default App;
