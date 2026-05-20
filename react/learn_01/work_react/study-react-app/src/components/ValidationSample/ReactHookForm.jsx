import { useForm } from "react-hook-form";

export function ReactHookForm() {
  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm();

  const mySubmit = (data) => {
    alert(`送信された名前: ${data.name}`);
  };

  return (
    <form onSubmit={handleSubmit(mySubmit)}>
      <input
        {...register("name", {
          required: "名前は必須です",
          minLength: {
            value: 2,
            message: "名前は2文字以上です。",
          },
          pattern: {
            value: /^[^0-9]*$/,
            message: "数字を使用できません",
          },
        })}
        placeholder="input name..."
      />

      <p style={{ color: "red" }}>{errors.name?.message}</p>
      <button type="submit">submit</button>
    </form>
  );
}
