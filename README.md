# login_firebase_bloc

Flutter project for practice with flutter_bloc 

## สร้าง Package Authenticate Repository ไว้ใช้

  เพื่อจะดูแลในส่วนของรายละเอียดชองวิธีที่จะ authenticated และ fetch(ดึง) ข้อมูลผู้ใช้

- user.dart
  
  สร้างเป็น models สำหรับระบุประเภทค่าของ User ภายใน authentication domain
  
- authentication_repository.dart
  
  จะจัดการในส่วนของวิธีการที่จะ authenticated ร่วมไปจนถึงวิธีการที่ user จะถูกดึงมาใช้ (fetched)

_________________________________________________________________________________________________________________________________________________________

### ในส่วนของตัว Application 

- App Bloc

    จะจัดการในส่วนของ global state ของ application แล้วยังมีตัว dependency บนตัว AuthenticationRepository และ ติดตามตัว user Stream ตามลำดับที่ส่งออก(emit) new state ในการตอบสนองการเปลี่ยนแปลงของ user ปัจจุบัน

    - app_event.dart

        จัดการในส่วนของเหตุการต่างๆ เพื่อสื่อสารกับตัว app_bloc ใน directory ของ app 

        โดยใน event มี 2 subclasses 

            1.AppUserChanged จะแจ้ง bloc เกี่ยวกับ user ปัจจุบันนั้นถูกเปลี่ยนแปลง

            2.AppLogoutRequested จะแจ้ง bloc เกี่ยวกับการที่ user ปัจจุบันนั้นขอ logout

    - app_state.dart

        จะทำการระบุสถานะของ app ซึ่งมีอยู่ 2 สถานะ ก็คือ authenticated และ unauthenticated
        
    - app_bloc.dart

        จะตอบสนองโดยรับ  app_event เข้ามา และจะเปลี่ยนรูปแบบโดยส่ง app_state ออกไป 

    
        


    
