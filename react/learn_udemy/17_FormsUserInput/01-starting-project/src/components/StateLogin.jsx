import Input from "./Input.jsx";
import { isEmail, isNotEmpty, hasMinLength } from "../util/validation.js";
import { useInput } from "../hooks/useInput";

export default function Login() {
  const {
    value: emailValue,
    onChange: handleEmailChange,
    onBlur: handleEmailBlur,
    hasError: emailHasError,
  } = useInput("", (value) => isNotEmpty(value) && isEmail(value));

  const {
    value: passwordValue,
    onChange: handlePasswordChange,
    onBlur: handlePasswordBlur,
    hasError: passwordHasError,
  } = useInput("", (value) => hasMinLength(value, 6));

  // const emailIsInvalid =
  //   didEdit.email && !isNotEmpty(emailValue) && !isEmail(emailValue);
  // const passwordIsInvalid = didEdit.password && hasMinLength(passwordValue, 6);

  function handleSubmit(e) {
    e.preventDefault(); // デフォルトの動作をキャンセル
    //console.log("handleSubmited-enteredValue: %o", enteredValue);
    if (emailHasError || passwordHasError) {
      return;
    }

    console.log(`http request... ${emailValue}, ${passwordValue}`);
  }

  return (
    <form onSubmit={handleSubmit}>
      <h2>Login</h2>

      <div className="control-row">
        <Input
          label="email"
          id="email"
          type="text" // emailだとブラウザ側のチェックが走るためtextにしている
          name="email"
          onChange={handleEmailChange}
          onBlur={handleEmailBlur}
          value={emailValue}
          error={emailHasError && "Please enter a valid email address."}
        />

        <div className="control no-margin">
          <Input
            label="password"
            id="password"
            type="password"
            name="password"
            onChange={handlePasswordChange}
            onBlur={handlePasswordBlur}
            value={passwordValue}
            error={!passwordHasError && "Please enter a valid password."}
          />
        </div>
      </div>

      <p className="form-actions">
        <button className="button button-flat">Reset</button>
        <button className="button">Login</button>
      </p>
    </form>
  );
}
