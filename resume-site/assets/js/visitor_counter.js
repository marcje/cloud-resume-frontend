const counterParagraph = document.querySelector("#visitor-counter");
COUNTER_API = 'https://e949f5af.azurewebsites.net/api/visitor_counter?code=Y_mL9yu7qqYy-nGDSXAb8AaeJjGiwwXA9VO05Q7NaL_fAzFuo9Nr8Q==';

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