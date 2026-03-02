function yandex --description Yandex
    echo "Yandex here! Setting up YA..."
    set -gx GOROOT (ya tool go --print-toolchain-path)
    set -gx ARCADIA /Users/kotsmile/arcadia
    set -gx NODE_EXTRA_CA_CERTS /etc/ssl/certs/YandexInternalCA.pem
    set -gx PATH $GOROOT/bin $PATH
end
