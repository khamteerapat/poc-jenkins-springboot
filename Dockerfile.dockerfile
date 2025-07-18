# 🌱 Stage 1: Build Spring Boot app ด้วย Maven และ JDK 21
FROM maven:3.9.6-eclipse-temurin-21 AS builder

# ตั้ง working directory
WORKDIR /build

# คัดลอกไฟล์สำหรับ build
COPY pom.xml .
COPY src ./src

# Build jar โดยข้าม test
RUN mvn clean package -DskipTests

# 🧊 Stage 2: สร้าง container ที่รันแอป ด้วย JDK 21 แบบบางเบา
FROM eclipse-temurin:21-jdk-jammy

# Working directory ภายใน container
WORKDIR /app

# คัดลอก JAR จาก builder stage
COPY --from=builder /build/target/*.jar app.jar

# เปิดพอร์ตแอป (เปลี่ยนได้ตาม app คุณ)
EXPOSE 8080

# รันแอป
ENTRYPOINT ["java", "-jar", "app.jar"]
