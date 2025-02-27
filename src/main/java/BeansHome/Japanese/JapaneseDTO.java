// #################################################################################################
// JapaneseDTO.java - 일본어 DTO 모듈
// #################################################################################################
// ═════════════════════════════════════════════════════════════════════════════════════════
// 외부모듈 영역
// ═════════════════════════════════════════════════════════════════════════════════════════
package BeansHome.Japanese;

import Common.ExceptionMgr;

// ═════════════════════════════════════════════════════════════════════════════════════════
// 사용자정의 클래스 영역
// ═════════════════════════════════════════════════════════════════════════════════════════
/***********************************************************************
 * JapaneseDTO		: 일본어 DTO 클래스<br>
 * Inheritance	    : None
 ***********************************************************************/
public class JapaneseDTO
{
    // —————————————————————————————————————————————————————————————————————————————————————
    // 전역상수 관리 - 필수영역
    // —————————————————————————————————————————————————————————————————————————————————————

    // —————————————————————————————————————————————————————————————————————————————————————
    // 전역변수 관리 - 필수영역(정적변수)
    // —————————————————————————————————————————————————————————————————————————————————————

    // —————————————————————————————————————————————————————————————————————————————————————
    // 전역변수 관리 - 필수영역(인스턴스변수)
    // —————————————————————————————————————————————————————————————————————————————————————
    /** japaneseId    : 일본어 번호 */
    private int japaneseId;
    /** wordsId       : 단어장 번호 */
    private int wordsId;
    /** kanji         : 한자 */
    private String kanji;
    /** hiragana      : 히라가나 */
    private String hiragana;
    /** kanjiKr       : 한자 한글 뜻 */
    private String kanjiKr;
    /** example       : 예문 일본어 */
    private String example;
    /** exampleKr     : 예문 한글 뜻 */
    private String exampleKr;

    // —————————————————————————————————————————————————————————————————————————————————————
    // 생성자 관리 - 필수영역(인스턴스함수)
    // —————————————————————————————————————————————————————————————————————————————————————
    /***********************************************************************
     * JapaneseDTO()    :  기본 생성자
     * @param void      : None
     ***********************************************************************/
    public JapaneseDTO()
    {
        try
        {
            // -----------------------------------------------------------------------------
            // 기타 초기화 작업 관리
            // -----------------------------------------------------------------------------
            ExceptionMgr.SetMode(ExceptionMgr.RUN_MODE.DEBUG);
            // -----------------------------------------------------------------------------
        }
        catch (Exception Ex)
        {
            ExceptionMgr.DisplayException(Ex);		// 예외처리(콘솔)
        }
    }
    // —————————————————————————————————————————————————————————————————————————————————————
    // 전역함수 관리 - 필수영역(정적함수)
    // —————————————————————————————————————————————————————————————————————————————————————

    // —————————————————————————————————————————————————————————————————————————————————————
    // 전역함수 관리 - 필수영역(인스턴스함수)
    // —————————————————————————————————————————————————————————————————————————————————————
    public int getJapaneseId() {
        return japaneseId;
    }

    public void setJapaneseId(int japaneseId) {
        this.japaneseId = japaneseId;
    }

    public int getWordsId() {
        return wordsId;
    }

    public void setWordsId(int wordsId) {
        this.wordsId = wordsId;
    }

    public String getKanji() {
        return kanji;
    }

    public void setKanji(String kanji) {
        this.kanji = kanji;
    }

    public String getHiragana() {
        return hiragana;
    }

    public void setHiragana(String hiragana) {
        this.hiragana = hiragana;
    }

    public String getKanjiKr() {
        return kanjiKr;
    }

    public void setKanjiKr(String kanjiKr) {
        this.kanjiKr = kanjiKr;
    }

    public String getExample() {
        return example;
    }

    public void setExample(String example) {
        this.example = example;
    }

    public String getExampleKr() {
        return exampleKr;
    }

    public void setExampleKr(String exampleKr) {
        this.exampleKr = exampleKr;
    }
    // —————————————————————————————————————————————————————————————————————————————————————
}
// #################################################################################################
// <END>
// #################################################################################################