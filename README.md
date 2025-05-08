# Basic-CRUD Project

## 🚀 프로젝트 소개 및 목적

웹 개발 중에 기본인 CRUD 를 공부하고 학습하기 위해 만들어본 프로젝트 입니다.
SpringBoot 와 MyBatis 를 활용하여 작업 하였습니다. 

추가적으로 파일업로드시 해당 파일에 바이러스가 없는지 확인하기 위해 [Clamav](!https://www.clamav.net/) 를 설정 해봤습니다.
자세한 코드는 `/src/main/java/com/crud/file` 를 확인해보세요.

## 주요 기능

*   **게시글 작성 (Create):** 새로운 게시글을 작성하고 데이터베이스에 저장합니다.
*   **게시글 목록 조회 (Read):** 작성된 게시글 목록을 페이징 기능과 함께 조회합니다.
*   **게시글 상세 조회 (Read):** 특정 게시글의 내용을 상세하게 조회합니다.
*   **게시글 수정 (Update):** 작성된 게시글의 내용을 수정하고 데이터베이스에 반영합니다.
*   **게시글 삭제 (Delete):** 작성된 게시글을 데이터베이스에서 삭제합니다.
*   **사용자 관리 (회원가입, 로그인):** 기본적인 사용자 회원가입 및 로그인 기능을 제공하여 게시판 기능과 연동합니다.
*   **파일 업로드 및 다운로드:** 게시글에 파일을 첨부하고 다운로드할 수 있는 기능을 제공합니다.

## 🏗️ 아키텍처 및 기술 스택

이 프로젝트는 다음과 같은 기술 스택과 아키텍처로 구성되어 있습니다.

*   **아키텍처:** 기본적인 MVC(Model-View-Controller) 패턴을 따르며, 각 계층의 역할을 명확히 구분하여 코드의 가독성과 유지보수성을 높였습니다.
*   **백엔드:**
    *   **Spring Boot:** 빠르고 쉽게 스프링 기반 애플리케이션을 개발할 수 있도록 도와주는 프레임워크입니다.
    *   **MyBatis:** SQL Mapper 프레임워크로, SQL 문을 XML 파일에 분리하여 관리하며 객체와 매핑하는 데 유용합니다.
*   **데이터베이스:**
    *   **MySQL:** 관계형 데이터베이스 관리 시스템으로, 프로젝트 데이터를 저장하고 관리합니다. (docker-compose를 통해 간편하게 실행 가능)
*   **프론트엔드:**
    *   **JSP (JavaServer Pages):** 동적인 웹 페이지를 생성하는 데 사용되는 기술입니다.
    *   **HTML, CSS, JavaScript:** 기본적인 웹 페이지 구조, 스타일링 및 동적인 처리를 위해 사용됩니다.
*   **빌드 도구:**
    *   **Gradle:** 유연하고 강력한 빌드 자동화 도구입니다.

## 🏁 프로젝트 실행 방법

### 1. 프로젝트 클론

```bash
git clone https://github.com/yourusername/Basic-CRUD.git
cd Basic-CRUD
```

### 2. Docker 및 MariaDB 설정

프로젝트에서 MariaDB와 ClamAV를 Docker로 실행하려면, `docker-compose.yml` 파일을 사용하여 서비스들을 설정합니다.

```bash
docker-compose up -d
```

`docker-compose.yml`에 정의된 `mariadb` 및 `clamav` 서비스가 실행됩니다.

### 3. 환경 변수 설정

`application.properties` 파일이나 `.env` 파일에서 다음과 같은 MariaDB 연결 정보를 설정합니다:

```properties
spring.datasource.url=jdbc:mysql://localhost:3390/mydatabase
spring.datasource.username=myuser
spring.datasource.password=mypassword
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
```

이 정보를 사용하여 Spring Boot 애플리케이션에서 MariaDB에 연결됩니다.

### 4. Gradle 빌드 및 실행

Gradle을 사용하여 프로젝트를 빌드하고 실행합니다:

```bash
./gradlew build
./gradlew bootRun
```

### 5. 애플리케이션 실행

Spring Boot 애플리케이션이 실행되면, 웹 브라우저에서 `http://localhost:8080`으로 접속하여 프로젝트를 테스트할 수 있습니다.

### 6. ClamAV 설정

파일 업로드 시 바이러스 검사를 위해 ClamAV를 설정하였습니다. 파일 업로드 기능을 사용할 때, 자동으로 업로드된 파일에 대해 ClamAV가 검사됩니다.

```txt
X5O!P%@AP[4\PZX54(P^)7CC)7}$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*
```
위 txt 저장하고 파일 업로드시 바이러스로 인식하는걸 확인할수 있습니다.

### 7. 데이터베이스 초기화

MariaDB가 처음 실행되면, 테이블 생성 쿼리를 포함한 `init.sql` 파일을 `/docker-entrypoint-initdb.d/` 폴더에 넣어 MariaDB가 시작될 때 자동으로 실행되도록 설정할 수 있습니다.

```bash
# 예시 SQL 파일 위치
./init.sql:/docker-entrypoint-initdb.d/init.sql
```

위와 같이 설정하면, MariaDB가 시작될 때 `init.sql` 파일이 실행되어 필요한 테이블이 자동으로 생성됩니다.