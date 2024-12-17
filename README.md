# ubuntu_environment_setup

## 사용 가능 환경
- ubuntu 22.04 LTS Desktop
- 지원하는 CPU 아키텍처
    - ARM64
    - x86_64

## 사용 방법
1. setup.sh 실행
```bash
./setup.sh
```
2. install_gazebo.sh 실행
```bash
./install_gazebo.sh
```
- ARM64 환경인 경우 ~/Documents/gazebo-classic 디렉토리 생성 후 빌드
- x86_64 환경인 경우 humble에서 제공하는 기본 gazebo 설치