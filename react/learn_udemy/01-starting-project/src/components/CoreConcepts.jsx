import { CORE_CONCEPTS } from "@/data.js";
import CoreCocept from "@/components/CoreConcept.jsx";
import Section from "@/components/Section.jsx";

export default function CoreCocepts() {
  return (
    <>
      <Section title="Core Concepts" id="core-concepts">
        <ul>
          {CORE_CONCEPTS.map((concept) => (
            <CoreCocept key={concept.title} {...concept} />
          ))}
        </ul>
      </Section>
    </>
  );
}
