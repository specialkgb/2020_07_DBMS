# git-hub에 프로젝트 업로드 하기

### 최초로 git-hub에 프로젝트 업로드 하기
1. git init : 현재 폴더를 git-hub에 올리기 위한 local repository로 생성

#### 생성된 local repository에 git-hub접속 정보 추가

##### 공용 또는 여러사람이 사용하는 컴퓨터인 경우 폴더별로 사용자를 변경하고자 할때
1. git config --local user.name userID
2. git config --local user.email user@user.com

##### 혼자 사용하는 컴퓨터에서는 글로벌로 설정값을 저장
1. git config --global user.name userID
2. git config --global user.email user@user.com
3. git config를 global로 설정하게 되면, local repository를 생성할 때마다 git config를 실행하지 않아도 된다.

### remote repository 정보 추가
1. git-hub 사이트에 접속하여 new repository를 설정
2. git remote add origin https://github.com/smskit726/Biz_506_2020_07_DBMS.git : remote repository 추가
3. git hub의 remote repository인 git remote add origin https://github./smskit726/Biz_506_2020_07_DBMS.git 이 주소를 origin이라는 이름으로 사용하겠다.

### git-hub에 프로젝트 올릴때, 올릴때마다 항상 실행해야 한다.
1. git add . : 현재폴더, sub 폴더의 모든 파일을 local repository(.git 폴더)에 압축, 해쉬하여 저장하라
2. git commit -m "Comment" : 지금 시점에 추가된 프로젝트를 COmment라는 설명을 부착하여 remote에 올릴 준비를 하라
3. git push -u origin master : master(local)에 저장된 프로젝트를 origin(remote)에 보내라
4. git push : 최초에 push할 때는 git push -u origin master라고 명령을 수행해야 하는데, 두번째 이후부터는 git push라고만 명령을 내리면 된다.

### git-hub에 올려진 프로젝트를 학원, 집에서 공동으로 작업할 경우
1. 학원에서 코딩한 후 프로젝트를 add, commit, push하여 upload
2. 집에서 git clone "remote주소" 하여 DownLoad
3. 집에서 프로젝트 코딩 추가, 변경
4. 집에서 git config 수행, 이 때는 처음 수행한 user.name, user.email과 같게 해야한다.
5. 집에서 git push -u origin master
6. 학원에 오면 제일먼저 할 일이 "git pull"을 수행하여 집에서 업로드한 프로젝트와 학원의 프로젝트를 동기화 시켜야 한다.
7. 학원에서 코딩 추가, 변경한 후 반복 작업
8. 혹시 github.com 에서 코드를 변경하거나, 어떤 작업을 수행했으면 반드시 로컬에서 git pull을 수행하자, 이것을 무시하면 remote repository를 지우고 다시 만들어야 하는 경우가 발생할 수 있다.
