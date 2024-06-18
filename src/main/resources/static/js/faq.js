function toggleAnswer(element) {
    const answer = element.nextElementSibling;
    if (answer.style.display === "block") {
        answer.style.display = "none";
        element.style.backgroundColor = "";
        element.style.color = "";
    } else {
        answer.style.display = "block";
        element.style.backgroundColor = "#F2F8ED";
        element.style.color = "#333232";
    }
}
