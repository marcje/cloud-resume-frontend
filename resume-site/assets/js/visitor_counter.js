const counterParagraph = document.querySelector("#visitor-counter");
if (window.location.hostname === 'resume-staging.itsburning.nl') {
  env = 's'
  key = 'b6ypZ3KwPN_aKIu1sBfULp5lZqKxxOUiRbuhikgv7qiPAzFuLgUFow=='
}
else {
  env = 'p'
  key = 'rW97JzPfHYVTSdUyE9ixm6QF6BrHoQwU9uNh9cPDGaTKAzFuGvyKeQ=='
}
COUNTER_API = `https://mtb-${env}-cv-backend-func.azurewebsites.net/api/visitor_counter?code=${key}`;

const fetchVisitorCounter = async (event) => {
  const fetchedResult = await fetch(COUNTER_API, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
  });
  const resultSet = await fetchedResult.json();
  counterParagraph.textContent = `Unique site views after latest database reset: ${resultSet.visitor_count}`;
};

window.addEventListener("DOMContentLoaded", fetchVisitorCounter);