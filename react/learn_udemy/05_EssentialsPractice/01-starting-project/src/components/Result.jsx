import { calculateInvestmentResults, formatter } from "../util/investment.js";

export default function Result({ input }) {
  //console.log(input);
  const resultData = calculateInvestmentResults(input);
  // console.log(resultData);

  const initialInvestment =
    resultData[0].valueEndOfYear - resultData[0].interest - resultData[0].annualInvestment;

  return (
    <table id="result">
      <thead>
        <tr>
          <th>Year</th>
          <th>Investment Value</th>
          <th>Interest(Year)</th>
          <th>Total Interest</th>
          <th>Invested Capital</th>
        </tr>
      </thead>
      <tbody>
        {resultData.map((item) => {
          const totalInterest =
            item.valueEndOfYear - item.annualInvestment * item.year - initialInvestment;
          const totalAmountInvested = item.valueEndOfYear - totalInterest;

          return (
            <tr key={item.year}>
              <td>{item.year}</td>
              <td>{formatter.format(item.valueEndOfYear)}</td>
              <td>{formatter.format(item.interest)}</td>
              <td>{formatter.format(totalInterest)}</td>
              <td>{formatter.format(totalAmountInvested)}</td>
            </tr>
          );
        })}
      </tbody>
    </table>
  );
}
