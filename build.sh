for tag in 2019.10 latest
do
    docker build -t rnakato/anaconda3:$tag .
    docker push rnakato/anaconda3:$tag
done
