import { BrowserRouter, Routes, Route } from "react-router-dom";
import { Home } from "@/components/RouterSample/Home";
import { About } from "@/components/RouterSample/About";
import { Contact } from "@/components/RouterSample/Contact";
import { Header } from "@/components/RouterSample/Header";

import "./App.css";
import { ValidationForm } from "@/components/ValidationSample/ValidationhForm";
import { ReactHookForm } from "@/components/ValidationSample/ReactHookForm";

import { ButtonExample } from "@/components/MUISample/BunttonExample";

import { AxiosExample } from "@/components/AxiosSample/AxiosExample";

// function

// import { useState } from "react";
// import { UserList } from "@/pages/UserList.jsx";
// import { CounterApp } from "@/components/CounterApp.jsx";
// import { TextInputSample } from "@/components/TextInputSample.jsx";
// import { ToggleSwitch } from "@/components/ToggleSwitch";
// import { TotalDisplay } from "@/components/TotalDisplay";
// import { FormApp } from "@/components/EventSample/FormApp";
// import { EveryRender } from "@/components/EffectSample/EveryRender";
// import { FirstTimeOnly } from "@/components/EffectSample/FirstTimeOnly";
// import { NameWatch } from "@/components/EffectSample/NameWatch";
// import { TimerComponent } from "@/components/EffectSample/TimerComponent";
// import { Parent } from "@/components/PropsDrillingSample/Parent";
// import { Parent } from "@/components/ContextSample/Parent";
// import { UserContext } from "@/components/ContextSample/UserContext";

// function App() {
//   return (
//     <BrowserRouter>
//       <h1>React Router</h1>
//       <Header />
//       <hr></hr>
//       <Routes>
//         <Route path="/" element={<Home />} />
//         <Route path="/about" element={<About />} />
//         <Route path="/contact" element={<Contact />} />
//       </Routes>
//     </BrowserRouter>
//   );
// }

// function App() {
//   // const [showTimer, setShowTimer] = useState(true);

//   const user = {
//     name: "tarou",
//     age: 20,
//     hobby: "soccer",
//   };

//   return (
//     <>
//       {/* <UserList />
//       <hr width="100%" />
//       <CounterApp />
//       <hr width="100%" />
//       <TextInputSample />
//       <hr width="100%" />
//       <ToggleSwitch />
//       <hr width="100%" />
//       <TotalDisplay />
//       <hr width="100%" />
//       <FormApp></FormApp> */}

//       {/* <EveryRender />
//       <hr width="100%" />
//       <FirstTimeOnly></FirstTimeOnly>
//       <hr width="100%" />
//       <NameWatch />
//       <hr width="100%" />

//       <h1>useEffect clearn up</h1>
//       <button onClick={() => setShowTimer(!showTimer)}>{showTimer ? "Timer停止" : "Timer再開"}</button>
//       {showTimer && <TimerComponent />}

//       <hr width="100%" />
//       <Parent user={data} /> */}

//       <UserContext.Provider value={user}>
//         <h1>context api</h1>
//         <Parent />
//       </UserContext.Provider>
//     </>
//   );
// }

function App() {
  return (
    <>
      {/* <h2>検証</h2> */}
      {/* <ValidationForm /> */}
      <ReactHookForm />
      {/* <ButtonExample></ButtonExample> */}
      {/* <AxiosExample /> */}
    </>
  );
}

export default App;
