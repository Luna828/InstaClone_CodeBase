# InstaClone_CodeBase [iOS_7기 앱개발 심화 개인과제]

[과제 URL](https://teamsparta.notion.site/iOS-cbdbd12c45784371bd93167719551d8a)

## 🔥필수구현 과제
1. 인스타 프로필 페이지 만들기 -> ProfileDesignViewController (Figma와 동일)
2. 지켜야할 사항
   - UICollectionView ✅
   - UILabel ✅
   - UIImageView ✅
   - UIButton ✅
   - UIView ✅
   - 구성요소 비율, 크기, 여백 구현 
   - 이미지는 Dummy Image 사용 ✅
   - Button Image는 Figma에서 export 후, Asset 형태 사용 ✅
3. Core Data 사용 ✅

## 🧨선택과제
1. 기기에 따른 해상도 대응 -> `UIScreen.main.bounds`활용해보기
2. Todo와 Category의 관계 정해주기
3. 기본앱 사진에 있는 사진 가져와서 UICollectionView에 보여주기 ✅
   - Photos 라이브러리 사용 ✅
   - 사진 생성순 ✅
   - 페이지네이션 고려 ❌ ✅
   - Simulator 기본 이미지들만도 OKAY ✅
## 앱 구조
![스크린샷 2023-09-21 오후 12 13 28](https://github.com/Luna828/InstaClone_CodeBase/assets/93186591/35bdcab1-e229-45b8-b883-d5a8950fc1f6)


## UI화면

<table>
   <tr>
      <td>
         <img src= "https://github.com/Luna828/InstaClone_CodeBase/assets/93186591/5c939207-2b7a-4a74-8ba6-4a4b42afcda0" />
      </td>
      <td>
         <img src= "https://github.com/Luna828/InstaClone_CodeBase/assets/93186591/98e03d26-6e4f-45e8-b366-25692f8d176d" />
      </td>
      <td>
         <img src= "https://github.com/Luna828/InstaClone_CodeBase/assets/93186591/0e602e7a-c666-4261-9bb9-8e682d8c5511" />
      </td>
      <td>
         <img src= "https://github.com/Luna828/InstaClone_CodeBase/assets/93186591/4cd0f0b8-c983-4aab-a0e4-3c4b07288fc9" />
      </td>
   </tr>
   <tr>
      <td>
         Todo페이지 + Delete
      </td>
      <td>
         Add Todo
      </td>
      <td>
         Update Todo
      </td>
       <td>
         Profile Page
      </td>
   </tr>
</table>


## 사용 라이브러리
```text
https://github.com/SnapKit/SnapKit
```

