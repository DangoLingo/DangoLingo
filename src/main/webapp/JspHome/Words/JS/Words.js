/* -----------------------------------------------------------------
    사용자 함수 및 로직 구현
   ----------------------------------------------------------------- */
// 변수 선언
const body = document.querySelector('body');
const label = document.querySelector('.label');
const options = document.querySelectorAll('.option-item');
// 클릭한 옵션의 텍스트를 라벨 안에 넣음
const handleSelect = function(item) {
    label.innerHTML = item.textContent;
    label.parentNode.classList.remove('active');
}
// 옵션 클릭시 클릭한 옵션을 넘김
options.forEach(function(option){
    option.addEventListener('click', function(){handleSelect(option)})
})
// 라벨을 클릭시 옵션 목록이 열림/닫힘
label.addEventListener('click', function(){
    if(label.parentNode.classList.contains('active')) {
        label.parentNode.classList.remove('active');
    } else {
        label.parentNode.classList.add('active');
    }
});
// 옵션 목록이 열린 상태에서 다른 영역 클릭 시 옵션 목록 닫힘
body.addEventListener('click', function(e) {
    if(!(e.target).classList.contains('label') && label.parentNode.classList.contains('active')){
        label.parentNode.classList.remove('active');
    }
});
/* -----------------------------------------------------------------
    END
   ----------------------------------------------------------------- */