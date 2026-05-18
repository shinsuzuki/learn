import "./App.css";
import { UserList } from "@/pages/UserList.jsx";
import { CounterApp } from "@/components/CounterApp.jsx";
import { TextInputSample } from "@/components/TextInputSample.jsx";
import { ToggleSwitch } from "@/components/ToggleSwitch";
import { TotalDisplay } from "@/components/TotalDisplay";
import { FormApp } from "@/components/EventSample/FormApp";

function App() {
  return (
    <>
      <UserList />
      <hr width="100%" />
      <CounterApp />
      <hr width="100%" />
      <TextInputSample />
      <hr width="100%" />
      <ToggleSwitch />
      <hr width="100%" />
      <TotalDisplay />
      <hr width="100%" />
      <FormApp></FormApp>
    </>
  );
}

export default App;
