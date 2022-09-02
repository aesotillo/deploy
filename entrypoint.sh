#!/bin/sh

echo "version: $INPUT_IMAGE_TAG"

export ECR_REPOSITORY=$(echo $GITHUB_REPOSITORY | cut -d "/" -f 2)

cd $INPUT_ENVIRONMENT/$INPUT_PRODUCT_VERSION/charts/$ECR_REPOSITORY/

# SUSTITUYE VERSION DE IMAGEN
echo "      tag:\ \${INPUT_IMAGE_TAG}" | tr -d '\' > version_tag.yaml
envsubst '${INPUT_IMAGE_TAG}' <version_tag.yaml > version_temp.yaml
sed "s/^.*tag:\ .*$/$(cat version_temp.yaml)/" values.yaml > tmpfile
cat tmpfile > values.yaml
rm version_tag.yaml version_temp.yaml tmpfile

# MUESTRA NUEVO values.yaml
cat values.yaml

# ACTUALIZA REPOSITORIO DE CHARTS DE HELM
git config --global user.email "aesotillo@github.com"
git config --global user.name "aesotillo DevOps BOT"
git add values.yaml && git commit -m "deploy to ${INPUT_ENVIRONMENT} version: ${INPUT_IMAGE_TAG} - product version: ${INPUT_PRODUCT_VERSION}" && git push --force origin develop

