#!/bin/bash

echo "⏳ جاري استخراج جميع الأسرار وتجهيز المفاتيح..."

# إنشاء المفاتيح
mkdir -p ~/.oci
openssl genrsa -out ~/.oci/sniper_key.pem 2048 2>/dev/null
chmod 600 ~/.oci/sniper_key.pem
openssl rsa -pubout -in ~/.oci/sniper_key.pem -out ~/.oci/sniper_pub.pem 2>/dev/null

# ربط المفتاح وسحب البصمة
FINGERPRINT=$(oci iam ipv4-api-key add --user-id $OCI_CS_USER_OCID --key-file ~/.oci/sniper_pub.pem --query "data.fingerprint" --raw-output)

# تنظيف الشاشة وعرض النتيجة
clear
echo "======================================================="
echo "🎯 تمت العملية بنجاح! انسخ هذي الـ 5 قيم إلى GitHub 🎯"
echo "======================================================="
echo ""
echo "1️⃣ OCI_USER_ID"
echo $OCI_CS_USER_OCID
echo ""
echo "2️⃣ OCI_TENANCY_ID"
echo $OCI_TENANCY
echo ""
echo "3️⃣ OCI_REGION"
echo $OCI_REGION
echo ""
echo "4️⃣ OCI_FINGERPRINT"
echo $FINGERPRINT
echo ""
echo "5️⃣ OCI_KEY_FILE (انسخ من أول شريطة BEGIN لآخر شريطة END)"
cat ~/.oci/sniper_key.pem
echo ""
echo "======================================================="
