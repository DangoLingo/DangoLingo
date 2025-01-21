// 모달 창 관련 함수
function ShowModalWindow(ModalSrc) {
    let divModalParent = document.getElementById("divModalParent");
    let divModalFrame = document.getElementById("divModalFrame");
    let ifModalWindow = document.getElementById("ifModalWindow");
    let btnClose = document.getElementById("btnClose");
    
    divModalFrame.style.display = "block";
    ifModalWindow.src = ModalSrc;
    btnClose.onclick = HideModalWindow;
}

function HideModalWindow() {
    divModalFrame.style.display = "none";
    location.reload(true);
} 