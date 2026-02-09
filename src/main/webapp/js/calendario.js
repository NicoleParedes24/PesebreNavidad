
document.querySelectorAll(".especial").forEach(d => {
    d.addEventListener("mouseenter", e => {
        const tooltip = document.getElementById("tooltip-calendario");
        tooltip.innerText = d.dataset.evento;
        tooltip.style.display = "block";
        tooltip.style.left = (e.pageX + 10) + "px";
        tooltip.style.top  = (e.pageY - 20) + "px";
    });

    d.addEventListener("mouseleave", () => {
        document.getElementById("tooltip-calendario").style.display = "none";
    });
});
