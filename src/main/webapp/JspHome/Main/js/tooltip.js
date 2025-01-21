class StreakTooltip {
    constructor() {
        this.cells = document.querySelectorAll('.streak-cell:not(.empty)');
        this.tooltipWidth = 120;
        this.tooltipHeight = 30;
        this.padding = 20;
        this.init();
    }

    init() {
        this.cells.forEach(cell => {
            cell.addEventListener('mouseenter', () => this.handleTooltipPosition(cell));
        });
    }

    handleTooltipPosition(cell) {
        // 기존 방향 클래스 제거
        cell.classList.remove('tooltip-bottom', 'tooltip-left', 'tooltip-right');

        const rect = cell.getBoundingClientRect();
        const container = document.querySelector('.streak-container').getBoundingClientRect();

        // 컨테이너 기준으로 상대 위치 계산
        const relativeTop = rect.top - container.top;
        const relativeLeft = rect.left - container.left;

        // 컨테이너 내에서의 위치에 따라 방향 결정
        if (relativeTop < this.tooltipHeight + this.padding) {
            // 위쪽 공간이 부족하면 아래로
            cell.classList.add('tooltip-bottom');
        } else if (relativeLeft < this.tooltipWidth / 2 + this.padding) {
            // 왼쪽 공간이 부족하면 오른쪽으로
            cell.classList.add('tooltip-right');
        } else if (container.width - relativeLeft < this.tooltipWidth / 2 + this.padding) {
            // 오른쪽 공간이 부족하면 왼쪽으로
            cell.classList.add('tooltip-left');
        }
    }
}

// DOM이 로드되면 초기화
document.addEventListener('DOMContentLoaded', () => {
    new StreakTooltip();
}); 