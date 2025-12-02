# 🌐 Static Website Hosting on AWS S3 using Terraform

This project hosts a **static website (HTML + CSS)** on **Amazon S3**
using **Terraform**.\
It creates the bucket, configures website hosting, uploads files, and
makes the website public.

## 🚀 Features

-   Creates an S3 bucket\
-   Enables static website hosting\
-   Uploads `index.html` and `styles.css`\
-   Applies bucket policy for public access\
-   Hosts the website with one Terraform command

## 🏗️ Architecture Diagram

                     +-------------------------------+
                     |        Terraform CLI          |
                     | terraform init/plan/apply     |
                     +---------------+---------------+
                                     |
                                     v
                        +------------+-------------+
                        |        AWS S3 Bucket     |
                        |  classic-bucket-xxxx     |
                        +------------+-------------+
                                     |
                      +--------------+---------------+
                      |  Public Bucket Policy        |
                      |  Allows GetObject ("*")      |
                      +--------------+---------------+
                                     |
                     +---------------+----------------+
                     |  Static Website Hosting        |
                     | index.html / styles.css        |
                     +---------------+----------------+
                                     |
                                     v
                            🌍 Public Website URL

## 📦 Resources Created by Terraform

  Resource Type               Description
  --------------------------- -----------------------------------------
  S3 Bucket                   Stores website files
  Bucket Ownership Controls   Allows ACL-based uploads
  Public Access Block         Disables blocking so site can be public
  Bucket Policy               Allows public GET access
  Website Configuration       Enables S3 static hosting
  S3 Objects                  Uploads index.html & styles.css

## 📁 Project Files

  File             Purpose
  ---------------- --------------------------------------------
  `main.tf`        Terraform script for full S3 website setup
  `index.html`     Your web page
  `styles.css`     Website styling
  `/screenshots`   Terraform & S3 screenshots

## 🛠️ Prerequisites

-   AWS Account\
-   IAM User with S3 + Terraform permissions\
-   AWS CLI configured\
-   Terraform installed

## ▶️ How to Deploy

### 1. Initialize Terraform

    terraform init

### 2. Format and Validate

    terraform fmt
    terraform validate

### 3. Apply the Infrastructure

    terraform apply

### 4. View the Website URL

Terraform outputs:

    website_link = http://classic-bucket-xxxx.s3-website.ap-south-1.amazonaws.com

## 🧹 Destroy Resources

    terraform destroy

## 👨‍💻 Author

**Prafull Sonawane**
