USE exercise;

# Division별 평점 분포 계산
## Division Name별 평균 평점
## Department별 평균 평점 
## Trend 리뷰중 3점 이하 리뷰
### Department가 Trend인 리뷰중 3점 이하 리뷰를 구하세요.
### (CASE WHEN 구문 활용) 먼저 고객의 나이를 아래 구간대로 그룹핑해주세요.     
### (FLOOR 함수 활용) 고객의 나이를 10살단위로 그룹핑해주세요.
### Department가 Trend인 리뷰 중 평점 3점 이하 리뷰의 연령 분포를 구하세요.
### Department가 Trend인 리뷰에서, 연령대별로 '리뷰수', '평점 3점 이하 리뷰수', '평점 3점 이하 리뷰 비중'을 구하세요. (NULL값의 경우 0으로 표시하세요.)
### Department가 Trend인 리뷰에서 30대 40대가 3점 이하 평점을 준 리뷰의 내용을 확인하세요.

# 평점이 낮은 상품의 주요 Complain
## Department별로 평균 평점이 가장 낮은 상품을 3개씩 조회해주세요.
## 위에서 Department별로 평균 평점이 가장 낮은 상품 3개의 Clothing ID를 구했습니다.
## 이를 활용해 Department별로 평균 평점이 가장 낮은 상품 3개의 Review Text를 조회해주세요.

# 연령별 Worst Department
## Trend를 제외한 Department중에서, 연령대별로 평균 평점이 가장 낮은 Department를 구하시오. 

# 리뷰 조작
## 평균평점 4.2미만인 Department Name의 평균 평점을 4.2로 만들기 위해서 Department Name별로 몇 개의 5점 평점이 필요한지를 구하세요. 

# 사이즈 컴플레인
## review text에 size라는 단어 언급 유무를 size_yn이라는 칼럼을 통해 나타내시오.
## 전체 리뷰 수와 전체 리뷰중 size라는 단어가 언급된 리뷰가 몇 건인지를 구하시오.
## 좀 더 쪼개서 확인해보고자 합니다. size란 단어 말고도 large, loose, small, tight란 단어에 대해서도 숫자를 확인해주세요.
## 위 결과를 연령대별, Department별로 쪼개서 구해주세요.
## 위 결과를 개수가 아닌 비율로 구해주세요.

# SIZE관련 얘기가 가장 많은 제품
## 리뷰가 10건 이상 달린 제품들의 리뷰 텍스트에서 'size, large, loose, small, tight' 단어 포함 비중을 구하라. 리뷰내 'size' 포함 비율이 높은 순서로 정렬하라.
