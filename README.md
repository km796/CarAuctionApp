# CarAuctionApp
아래의 비디오와 같이 동작하는 어플리케이션 입니다 

https://github.com/km796/CarAuctionApp/assets/31836577/76697965-cde6-4aed-9bde-c146dd01751a

## 사용한 기술
- Swift
- SwiftUI
- Combine

## 사용한 아키텍쳐
### Clean Architecture
Domain 을 가장 안쪽에 두고 그 위로 Presentation, Data 레이어들을 둬 의존성이 밖에서 안으로 향하게 개발해 앱의 확장성을 고려했습니다

### MVVM
SwiftUI 를 사용해 개발했기에 MVVM 으로 개발하기 쉬워진 부분들이 많이 있었고 TCA, ReactorKit 등은 3rd party 라이브러리들은 불필요한 의존성이 생기기에 고려하지 않았습니다.

## 사용한 라이브러리 
최대한 라이브러리 사용을 안하고 개발하려 노력했습니다.
- SDWebImageSwiftUI: 이미지 로딩을 위해 사용했습니다.
