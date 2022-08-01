<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../common/head.jspf"%>

<%-- listAuto 는 자동으로 변화가 반영되는 ! (f5키 필요없이) --%>

<script>
    let Articles__lastId = 0;
    // js에서 통신은 비동기로 실행됨
    function Articles__loadMore() {
        fetch(`/usr/article/getArticles/free?fromId=\${Articles__lastId}`)      // '\' 이 기호로 컴파일 시 렌더링
            // fetch 를 하면 통신이 발생 -> then 으로 비동기 통신 진행
            // then 은 통신이 완료된 이후 응답이 오면 실행된다.
            .then(data => data.json())      // JSON을 파싱
            .then(responseData => {
                const articles = responseData.data;
                for ( const index in articles ) {
                    const article = articles[index];
                    const html = `
                    <li class="flex">
                        <a class="w-[40px] hover:underline hover:text-blue-400" href="/usr/article/detail/free/${article.id}">${article.id}</a>
                        <a class="flex-grow hover:underline hover:text-blue-400" href="/usr/article/detail/free/${article.id}">${article.title}</a>
                        <a onclick="if ( !confirm('정말로 삭제하시겠습니까?') ) return false;" class="hover:underline hover:text-blue-700 mr-2" href="/usr/article/delete/free/${article.id}?_method=DELETE">삭제</a>
                        <a class="hover:underline hover:text-blue-700" href="/usr/article/modify/free/${article.id}">수정</a>
                    </li>
                `;
                    // jquery 찾기 : $ --> 하고 나서 articles의 class를 가지는 태그 아래 html 내용을 추가
                    $('.articles').append(html);
                }

                // 렌더링이 되면서 Articles__lastId 값이 계속 증가한다. (1 ~ 10)
                // 가까운 데이터가 있으면 현재 내가 가져온 데이터 중 가장 마지막이 Articles__lastId으로 들어감
                //      -> 이후에 이 함수를 실행한다면 어쨋든 제일 마지막 값이 들어가 있는 상태이기 때문에 더 추가로 불러올 수 없다.
                //      -> 그러나 새롭게 글을 쓰고 추가로 불러오게 된다면 로딩이 된다. (Articles__lastId 값이 새로 추가된 게시글 id로 변했기 때문)
                if ( articles.length > 0 ) {
                    Articles__lastId = articles[articles.length - 1].id;
                }
                // -> 즉, 이는 이미 가져온 데이터는 가져오지 않도록 처리해 준 것이다.

                // Articles__loadMore(); -> 이건 즉시 실행
                // 아래처럼 한다면 -> (Articles loadMore 함수에서, 통신이 끝나고 렌더링까지 마친 후, 3초뒤에 다시 실행을 예약하는 것)
                setTimeout(Articles__loadMore, 3000); // Articles__loadMore(); 를 3초 뒤에 수행

                /*
                setInterval == 매 3초마다 한번씩 걸기
                setTimeout == 3초 뒤에 한번만 실행
                 */
            });
    }
</script>

<section>
    <div class="container px-3 mx-auto">
        <h1 class="font-bold text-lg">게시물 리스트(오토)</h1>

        <!-- 여기 부분 -->
        <ul class="articles mt-5">
            <!-- 이 부분에 자바스크립트를 통해서 HTML을 채우겠습니다. -->
        </ul>

        <hr class="mt-3 mb-3">

        <!-- 자동으로 이 버튼이 3초에 한번씩 눌리고 있다. -->
        <button class="btn btn-sm btn-outline btn-info" onclick="Articles__loadMore();">추가로 불러오기</button>
    </div>
</section>

<script>
    Articles__loadMore();
</script>

<%@ include file="../common/foot.jspf"%>