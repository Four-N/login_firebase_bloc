# login_firebase_bloc

Flutter project for practice with flutter_bloc 

## สร้าง Package Authenticate Repository ไว้ใช้

- authentication_repository

    เพื่อจะดูแลในส่วนของรายละเอียดชองวิธีที่จะ authenticated และ fetch(ดึง) ข้อมูลผู้ใช้
    
    - user
  
        สร้างเป็น models สำหรับระบุประเภทค่าของ User ภายใน authentication domain
  
    - authentication_repository
  
        จะจัดการในส่วนของวิธีการที่จะ authenticated ร่วมไปจนถึงวิธีการที่ user จะถูกดึงมาใช้ (fetched)

- catch

    ทำหน้าที่ในการจัดการเกี่ยวกับ catch 

- form_input

    สร้างไว้ Validate logic input model ของ email และ password จะไปใช้ในส่วนของ Login form, Sign form
_________________________________________________________________________________________________________________________________________________________

### ในส่วนของตัว Application 

- App Bloc

    จะจัดการในส่วนของ global state ของ application แล้วยังมีตัว dependency บนตัว AuthenticationRepository และ ติดตามตัว user Stream ตามลำดับที่ส่งออก(emit) new state ในการตอบสนองการเปลี่ยนแปลงของ user ปัจจุบัน

    - app_event

        จัดการในส่วนของเหตุการต่างๆ เพื่อสื่อสารกับตัว app_bloc ใน directory ของ app 

        โดยใน event มี 2 subclasses 

            1.AppUserChanged จะแจ้ง bloc เกี่ยวกับ user ปัจจุบันนั้นถูกเปลี่ยนแปลง

            2.AppLogoutRequested จะแจ้ง bloc เกี่ยวกับการที่ user ปัจจุบันนั้นขอ logout

    - app_state

        จะทำการระบุสถานะของ app ซึ่งมีอยู่ 2 สถานะ ก็คือ authenticated และ unauthenticated
        
    - app_bloc

        จะตอบสนองโดยรับ  app_event เข้ามา และจะเปลี่ยนรูปแบบโดยส่ง app_state ออกไป 

- Log in

    - login_page

        จะรับผิดชอบในการ creat และ provide instance ของ LoginCubit ไปที่ LoginForm

    - login_state
        
        จะมีในส่วนของ email, password และ FormStatus โดย email และ password model จะ extend มาจาก FormInput จาก formz package
    
    - login_cubit
        
        จะจัดการเกี่ยวกับตัว login_state ของแบบ form มันจะ exposes APIs ไปที่ logInWithCredentials, logInWithGoogle รวมถึงจะรับการแจ้งให้รู้เมื่อ email/password นั้มีการอัพเดต

        มีการใช้ dependency บนตัวของ AuthenticationRepository เพื่อการ sign in ข้อมูลส่วนตัวของ user หรือ ผ่าน google sign in 

    - login_form

        จะดูแลเกี่ยวกับ render form ในการที่จะตอบสนองกับ login_state และจะเรียกใช้บนตัว login_cubit ในการตอบสนองกับ intetaction ของ user
    
- Sign up

    จะคล้ายๆ กับในส่วนของ Log in 

- Route

    สร้างไว้จัดการเกี่ยวกับการกำหนดหน้าที่แสดงใน app



![Alt text](assets/bloc_logo_small.png)