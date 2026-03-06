#!/bin/bash

# Setup WordPress + WooCommerce and create database dump
# Run this inside the PHP container: make shell && ./setup-wordpress.sh

set -e

WP_PATH="/var/www/html"
# Use 'wordpress' for Docker inter-container communication, 'localhost:8080' for local development
WP_URL="${WORDPRESS_URL:-http://wordpress}"
WP_TITLE="AztecWP Browser Test Site"
ADMIN_USER="${WP_ADMIN_USER:-admin}"
ADMIN_PASSWORD="${WP_ADMIN_PASSWORD:-password}"
ADMIN_EMAIL="${WP_ADMIN_EMAIL:-admin@example.com}"
DB_HOST="db"
DB_PORT="3306"
DB_NAME="${WORDPRESS_DB_NAME:-wordpress}"
DB_USER="${WORDPRESS_DB_USER:-wordpress}"
DB_PASSWORD="${WORDPRESS_DB_PASSWORD:-wordpress}"

echo "=== Waiting for database... ==="
echo "Connecting to $DB_HOST:$DB_PORT as $DB_USER..."
until mysql -h"$DB_HOST" -P"$DB_PORT" -u"$DB_USER" -p"$DB_PASSWORD" --skip-ssl -e "SELECT 1" 2>/dev/null; do
    echo "Waiting for database to be ready..."
    sleep 2
done
echo "Database is ready!"

echo "=== Resetting database... ==="
mysql -h"$DB_HOST" -P"$DB_PORT" -u"$DB_USER" -p"$DB_PASSWORD" --skip-ssl -e "DROP DATABASE IF EXISTS $DB_NAME; CREATE DATABASE $DB_NAME;" 2>/dev/null
echo "Database reset complete!"

echo "=== Creating WordPress configuration... ==="
cd "$WP_PATH"

if [ ! -f wp-config.php ]; then
    wp config create \
        --dbname="$DB_NAME" \
        --dbuser="$DB_USER" \
        --dbpass="$DB_PASSWORD" \
        --dbhost="$DB_HOST" \
        --allow-root
fi

echo "=== Installing WordPress... ==="
wp core install \
    --url="$WP_URL" \
    --title="$WP_TITLE" \
    --admin_user="$ADMIN_USER" \
    --admin_password="$ADMIN_PASSWORD" \
    --admin_email="$ADMIN_EMAIL" \
    --skip-email \
    --allow-root

echo "=== Copying WooCommerce and Storefront files... ==="
rm -rf "$WP_PATH/wp-content/plugins/woocommerce"
rm -rf "$WP_PATH/wp-content/themes/storefront"
cp -r /app/woocommerce "$WP_PATH/wp-content/plugins/"
cp -r /app/storefront "$WP_PATH/wp-content/themes/"

echo "=== Activating WooCommerce... ==="
wp plugin activate woocommerce --allow-root

echo "=== Activating Storefront theme... ==="
wp theme activate storefront --allow-root

echo "=== Enabling HPOS (High-Performance Order Storage)... ==="
wp wc hpos sync --allow-root
wp wc hpos enable --allow-root

echo "=== Running WooCommerce setup wizard (Brazilian configuration)... ==="
wp option update woocommerce_demo_store "no" --allow-root
wp option update woocommerce_coming_soon "no" --allow-root
wp option update woocommerce_store_address "Av. Paulista, 1000" --allow-root
wp option update woocommerce_store_city "São Paulo" --allow-root
wp option update woocommerce_default_country "BR:SP" --allow-root
wp option update woocommerce_store_postcode "01310-100" --allow-root
wp option update woocommerce_currency "BRL" --allow-root
wp option update woocommerce_price_thousand_sep "." --allow-root
wp option update woocommerce_price_decimal_sep "," --allow-root
wp option update woocommerce_price_num_decimals "2" --allow-root
wp option update woocommerce_weight_unit "kg" --allow-root
wp option update woocommerce_dimension_unit "cm" --allow-root

echo "=== Enabling Cash on Delivery payment method... ==="
wp wc payment_gateway update cod --enabled=true --user=1 --allow-root

echo "=== Creating realistic course products... ==="

PROD1_ID=$(wp wc product create \
    --name="Gestão do Conhecimento" \
    --type="simple" \
    --regular_price="129.00" \
    --description="Curso de extensão em Gestão do Conhecimento organizacional" \
    --short_description="Aprenda a gerenciar conhecimento na sua empresa" \
    --sku="EXT-001" \
    --manage_stock="false" \
    --status="publish" \
    --user=1 \
    --porcelain \
    --allow-root)
echo "Created product: Gestão do Conhecimento (ID: $PROD1_ID)"

PROD2_ID=$(wp wc product create \
    --name="Auditoria em Saúde" \
    --type="simple" \
    --regular_price="180.00" \
    --description="Curso de extensão em Auditoria em Saúde" \
    --short_description="Técnicas de auditoria no setor de saúde" \
    --sku="EXT-002" \
    --manage_stock="false" \
    --status="publish" \
    --user=1 \
    --porcelain \
    --allow-root)
echo "Created product: Auditoria em Saúde (ID: $PROD2_ID)"

PROD3_ID=$(wp wc product create \
    --name="Marketing Digital Avançado" \
    --type="simple" \
    --regular_price="159.00" \
    --description="Curso de extensão em Marketing Digital" \
    --short_description="Domine as estratégias de marketing digital" \
    --sku="EXT-003" \
    --manage_stock="false" \
    --status="publish" \
    --user=1 \
    --porcelain \
    --allow-root)
echo "Created product: Marketing Digital Avançado (ID: $PROD3_ID)"

PROD4_ID=$(wp wc product create \
    --name="Excel Avançado para Negócios" \
    --type="simple" \
    --regular_price="149.00" \
    --description="Curso de extensão em Excel" \
    --short_description="Domine o Excel para ambiente corporativo" \
    --sku="EXT-004" \
    --manage_stock="false" \
    --status="publish" \
    --user=1 \
    --porcelain \
    --allow-root)
echo "Created product: Excel Avançado para Negócios (ID: $PROD4_ID)"

PROD5_ID=$(wp wc product create \
    --name="Comunicação Assertiva" \
    --type="simple" \
    --regular_price="139.00" \
    --description="Curso de extensão em Comunicação" \
    --short_description="Melhore sua comunicação profissional" \
    --sku="EXT-005" \
    --manage_stock="false" \
    --status="publish" \
    --user=1 \
    --porcelain \
    --allow-root)
echo "Created product: Comunicação Assertiva (ID: $PROD5_ID)"

PROD6_ID=$(wp wc product create \
    --name="Formação Front-end Developer" \
    --type="simple" \
    --regular_price="1500.00" \
    --description="Formação completa em desenvolvimento front-end" \
    --short_description="Torne-se um desenvolvedor front-end" \
    --sku="FORM-001" \
    --manage_stock="false" \
    --status="publish" \
    --user=1 \
    --porcelain \
    --allow-root)
echo "Created product: Formação Front-end Developer (ID: $PROD6_ID)"

PROD7_ID=$(wp wc product create \
    --name="Formação Data Science" \
    --type="simple" \
    --regular_price="2200.00" \
    --description="Formação completa em Ciência de Dados" \
    --short_description="Domine análise de dados e machine learning" \
    --sku="FORM-002" \
    --manage_stock="false" \
    --status="publish" \
    --user=1 \
    --porcelain \
    --allow-root)
echo "Created product: Formação Data Science (ID: $PROD7_ID)"

PROD8_ID=$(wp wc product create \
    --name="Formação Full-stack Developer" \
    --type="simple" \
    --regular_price="3500.00" \
    --description="Formação completa em desenvolvimento full-stack" \
    --short_description="Domine front-end e back-end" \
    --sku="FORM-003" \
    --manage_stock="false" \
    --status="publish" \
    --user=1 \
    --porcelain \
    --allow-root)
echo "Created product: Formação Full-stack Developer (ID: $PROD8_ID)"

PROD9_ID=$(wp wc product create \
    --name="Curso Degustação - Introdução" \
    --type="simple" \
    --regular_price="0.00" \
    --description="Curso gratuito de introdução" \
    --short_description="Conheça nossa metodologia" \
    --sku="FREE-001" \
    --manage_stock="false" \
    --status="publish" \
    --user=1 \
    --porcelain \
    --allow-root)
echo "Created product: Curso Degustação (ID: $PROD9_ID)"

echo "=== Creating Brazilian customers... ==="

create_customer() {
    local first_name=$1
    local last_name=$2
    local email=$3
    local login="${first_name,,}.${last_name,,}"

    wp user create "$login" "$email" \
        --role=customer \
        --first_name="$first_name" \
        --last_name="$last_name" \
        --display_name="$first_name $last_name" \
        --user_pass="password" \
        --porcelain \
        --allow-root
}

CUST1_ID=$(create_customer "Maria" "Silva" "maria.silva123@gmail.com")
echo "Created customer: Maria Silva (ID: $CUST1_ID)"

CUST2_ID=$(create_customer "João" "Santos" "joaosantos@outlook.com")
echo "Created customer: João Santos (ID: $CUST2_ID)"

CUST3_ID=$(create_customer "Ana" "Oliveira" "ana.oliveira45@hotmail.com")
echo "Created customer: Ana Oliveira (ID: $CUST3_ID)"

CUST4_ID=$(create_customer "Carlos" "Souza" "carlos.souza@bol.com.br")
echo "Created customer: Carlos Souza (ID: $CUST4_ID)"

CUST5_ID=$(create_customer "Fernanda" "Costa" "fernanda.costa@gmail.com")
echo "Created customer: Fernanda Costa (ID: $CUST5_ID)"

CUST6_ID=$(create_customer "Pedro" "Lima" "pedro.lima@outlook.com")
echo "Created customer: Pedro Lima (ID: $CUST6_ID)"

CUST7_ID=$(create_customer "Juliana" "Ferreira" "juliana.ferreira@hotmail.com")
echo "Created customer: Juliana Ferreira (ID: $CUST7_ID)"

CUST8_ID=$(create_customer "Lucas" "Almeida" "lucas.almeida@gmail.com")
echo "Created customer: Lucas Almeida (ID: $CUST8_ID)"

CUST9_ID=$(create_customer "Camila" "Ribeiro" "camila.ribeiro@bol.com.br")
echo "Created customer: Camila Ribeiro (ID: $CUST9_ID)"

CUST10_ID=$(create_customer "Ricardo" "Pereira" "ricardo.pereira@outlook.com")
echo "Created customer: Ricardo Pereira (ID: $CUST10_ID)"

echo "=== Creating HPOS orders with Brazilian data... ==="

create_hpos_order() {
    local order_id=$1
    local status=$2
    local customer_id=$3
    local email=$4
    local total=$5
    local date_created=${6:-"$(date -u +%Y-%m-%d\ %H:%M:%S)"}

    wp db query "INSERT INTO wp_wc_orders (id, status, currency, type, total_amount, tax_amount, customer_id, billing_email, date_created_gmt, date_updated_gmt, payment_method, payment_method_title) VALUES ($order_id, '$status', 'BRL', 'shop_order', $total, 0, $customer_id, '$email', '$date_created', '$date_created', 'manual', 'Pagamento Manual')" --allow-root
}

create_billing_address() {
    local order_id=$1
    local first_name=$2
    local last_name=$3
    local address=$4
    local city=$5
    local state=$6
    local postcode=$7
    local email=$8
    local phone=$9

    wp db query "INSERT INTO wp_wc_order_addresses (order_id, address_type, first_name, last_name, address_1, city, state, postcode, country, email, phone) VALUES ($order_id, 'billing', '$first_name', '$last_name', '$address', '$city', '$state', '$postcode', 'BR', '$email', '$phone')" --allow-root
}

create_order_meta() {
    local order_id=$1
    local number=$2
    local neighborhood=$3
    local cellphone=$4
    local cpf=$5
    local persontype=${6:-"1"}

    wp db query "INSERT INTO wp_wc_orders_meta (order_id, meta_key, meta_value) VALUES
        ($order_id, '_billing_number', '$number'),
        ($order_id, '_billing_neighborhood', '$neighborhood'),
        ($order_id, '_billing_cellphone', '$cellphone'),
        ($order_id, '_billing_cpf', '$cpf'),
        ($order_id, '_billing_persontype', '$persontype'),
        ($order_id, '_payment_method', 'manual'),
        ($order_id, '_payment_method_title', 'Pagamento Manual'),
        ($order_id, '_recorded_sales', 'yes'),
        ($order_id, '_recorded_coupon_usage', 'yes')" --allow-root
}

create_order_item() {
    local order_id=$1
    local item_name=$2
    local product_id=$3
    local qty=$4
    local total=$5

    local item_id=$(wp db query "SELECT COALESCE(MAX(order_item_id), 0) + 1 FROM wp_woocommerce_order_items" --skip-column-names --allow-root)

    wp db query "INSERT INTO wp_woocommerce_order_items (order_item_id, order_item_name, order_item_type, order_id) VALUES ($item_id, '$item_name', 'line_item', $order_id)" --allow-root

    wp db query "INSERT INTO wp_woocommerce_order_itemmeta (order_item_id, meta_key, meta_value) VALUES
        ($item_id, '_product_id', '$product_id'),
        ($item_id, '_variation_id', '0'),
        ($item_id, '_qty', '$qty'),
        ($item_id, '_tax_class', ''),
        ($item_id, '_line_subtotal', '$total'),
        ($item_id, '_line_subtotal_tax', '0'),
        ($item_id, '_line_total', '$total'),
        ($item_id, '_line_tax', '0'),
        ($item_id, '_line_tax_data', 'a:2:{s:5:\"total\";a:0:{}s:8:\"subtotal\";a:0:{}}')" --allow-root
}

ORDER1_ID=1001
create_hpos_order $ORDER1_ID "wc-completed" $CUST1_ID "maria.silva123@gmail.com" 129.00
create_billing_address $ORDER1_ID "Maria" "Silva" "Rua das Flores" "São Paulo" "SP" "01310-000" "maria.silva123@gmail.com" "(11) 98765-4321"
create_order_meta $ORDER1_ID "123" "Centro" "(11) 98765-4321" "123.456.789-00"
create_order_item $ORDER1_ID "Gestão do Conhecimento" $PROD1_ID 1 129.00
echo "Created order #$ORDER1_ID (completed)"

ORDER2_ID=1002
create_hpos_order $ORDER2_ID "wc-completed" $CUST2_ID "joaosantos@outlook.com" 1500.00
create_billing_address $ORDER2_ID "João" "Santos" "Avenida Brasil" "Rio de Janeiro" "RJ" "20040-020" "joaosantos@outlook.com" "(21) 99876-5432"
create_order_meta $ORDER2_ID "1500" "Centro" "(21) 99876-5432" "987.654.321-00"
create_order_item $ORDER2_ID "Formação Front-end Developer" $PROD6_ID 1 1500.00
echo "Created order #$ORDER2_ID (completed)"

ORDER3_ID=1003
create_hpos_order $ORDER3_ID "wc-cancelled" $CUST3_ID "ana.oliveira45@hotmail.com" 180.00
create_billing_address $ORDER3_ID "Ana" "Oliveira" "Rua Augusta" "São Paulo" "SP" "01305-000" "ana.oliveira45@hotmail.com" "(11) 97654-3210"
create_order_meta $ORDER3_ID "500" "Consolação" "(11) 97654-3210" "456.789.123-00"
create_order_item $ORDER3_ID "Auditoria em Saúde" $PROD2_ID 1 180.00
echo "Created order #$ORDER3_ID (cancelled)"

ORDER4_ID=1004
create_hpos_order $ORDER4_ID "wc-failed" $CUST4_ID "carlos.souza@bol.com.br" 2200.00
create_billing_address $ORDER4_ID "Carlos" "Souza" "Rua Sete de Setembro" "Curitiba" "PR" "80020-010" "carlos.souza@bol.com.br" "(41) 96543-2109"
create_order_meta $ORDER4_ID "789" "Centro" "(41) 96543-2109" "789.123.456-00"
create_order_item $ORDER4_ID "Formação Data Science" $PROD7_ID 1 2200.00
echo "Created order #$ORDER4_ID (failed)"

ORDER5_ID=1005
create_hpos_order $ORDER5_ID "wc-pending" $CUST5_ID "fernanda.costa@gmail.com" 0.00
create_billing_address $ORDER5_ID "Fernanda" "Costa" "Rua Oscar Freire" "São Paulo" "SP" "01426-001" "fernanda.costa@gmail.com" "(11) 95432-1098"
create_order_meta $ORDER5_ID "321" "Jardins" "(11) 95432-1098" "321.654.987-00"
create_order_item $ORDER5_ID "Curso Degustação - Introdução" $PROD9_ID 1 0.00
echo "Created order #$ORDER5_ID (pending)"

ORDER6_ID=1006
create_hpos_order $ORDER6_ID "wc-completed" $CUST6_ID "pedro.lima@outlook.com" 288.00
create_billing_address $ORDER6_ID "Pedro" "Lima" "Avenida Paulista" "São Paulo" "SP" "01310-100" "pedro.lima@outlook.com" "(11) 94321-0987"
create_order_meta $ORDER6_ID "1000" "Bela Vista" "(11) 94321-0987" "654.987.321-00"
create_order_item $ORDER6_ID "Gestão do Conhecimento" $PROD1_ID 1 129.00
create_order_item $ORDER6_ID "Marketing Digital Avançado" $PROD3_ID 1 159.00
echo "Created order #$ORDER6_ID (completed)"

ORDER7_ID=1007
create_hpos_order $ORDER7_ID "wc-refunded" $CUST7_ID "juliana.ferreira@hotmail.com" 139.00
create_billing_address $ORDER7_ID "Juliana" "Ferreira" "Rua XV de Novembro" "Florianópolis" "SC" "88010-400" "juliana.ferreira@hotmail.com" "(48) 93210-9876"
create_order_meta $ORDER7_ID "200" "Centro" "(48) 93210-9876" "987.321.654-00"
create_order_item $ORDER7_ID "Comunicação Assertiva" $PROD5_ID 1 139.00
echo "Created order #$ORDER7_ID (refunded)"

ORDER8_ID=1008
create_hpos_order $ORDER8_ID "wc-completed" $CUST8_ID "lucas.almeida@gmail.com" 3500.00
create_billing_address $ORDER8_ID "Lucas" "Almeida" "Avenida Atlântica" "Rio de Janeiro" "RJ" "22021-001" "lucas.almeida@gmail.com" "(21) 92109-8765"
create_order_meta $ORDER8_ID "500" "Copacabana" "(21) 92109-8765" "321.987.654-00"
create_order_item $ORDER8_ID "Formação Full-stack Developer" $PROD8_ID 1 3500.00
echo "Created order #$ORDER8_ID (completed)"

ORDER9_ID=1009
create_hpos_order $ORDER9_ID "wc-completed" $CUST9_ID "camila.ribeiro@bol.com.br" 149.00
create_billing_address $ORDER9_ID "Camila" "Ribeiro" "Rua da Praia" "Porto Alegre" "RS" "90040-000" "camila.ribeiro@bol.com.br" "(51) 91098-7654"
create_order_meta $ORDER9_ID "150" "Centro Histórico" "(51) 91098-7654" "654.321.987-00"
create_order_item $ORDER9_ID "Excel Avançado para Negócios" $PROD4_ID 1 149.00
echo "Created order #$ORDER9_ID (completed)"

ORDER10_ID=1010
create_hpos_order $ORDER10_ID "wc-completed" $CUST10_ID "ricardo.pereira@outlook.com" 180.00
create_billing_address $ORDER10_ID "Ricardo" "Pereira" "Avenida Afonso Pena" "Belo Horizonte" "MG" "30130-007" "ricardo.pereira@outlook.com" "(31) 90987-6543"
create_order_meta $ORDER10_ID "1001" "Centro" "(31) 90987-6543" "987.654.321-00"
create_order_item $ORDER10_ID "Auditoria em Saúde" $PROD2_ID 1 180.00
echo "Created order #$ORDER10_ID (completed)"

ORDER11_ID=1011
create_hpos_order $ORDER11_ID "wc-on-hold" 0 "guest@example.com" 159.00
create_billing_address $ORDER11_ID "Roberto" "Guest" "Rua Teste" "Brasília" "DF" "70040-010" "guest@example.com" "(61) 99876-5432"
create_order_meta $ORDER11_ID "100" "Asa Sul" "(61) 99876-5432" "111.222.333-44"
create_order_item $ORDER11_ID "Marketing Digital Avançado" $PROD3_ID 1 159.00
echo "Created order #$ORDER11_ID (on-hold)"

ORDER12_ID=1012
create_hpos_order $ORDER12_ID "wc-processing" $CUST2_ID "joaosantos@outlook.com" 2200.00
create_billing_address $ORDER12_ID "João" "Santos" "Avenida Brasil" "Rio de Janeiro" "RJ" "20040-020" "joaosantos@outlook.com" "(21) 99876-5432"
create_order_meta $ORDER12_ID "1500" "Centro" "(21) 99876-5432" "987.654.321-00"
create_order_item $ORDER12_ID "Formação Data Science" $PROD7_ID 1 2200.00
echo "Created order #$ORDER12_ID (processing)"

ORDER13_ID=1013
create_hpos_order $ORDER13_ID "wc-completed" $CUST3_ID "ana.oliveira45@hotmail.com" 417.00
create_billing_address $ORDER13_ID "Ana" "Oliveira" "Rua Augusta" "São Paulo" "SP" "01305-000" "ana.oliveira45@hotmail.com" "(11) 97654-3210"
create_order_meta $ORDER13_ID "500" "Consolação" "(11) 97654-3210" "456.789.123-00"
create_order_item $ORDER13_ID "Gestão do Conhecimento" $PROD1_ID 1 129.00
create_order_item $ORDER13_ID "Excel Avançado para Negócios" $PROD4_ID 1 149.00
create_order_item $ORDER13_ID "Comunicação Assertiva" $PROD5_ID 1 139.00
echo "Created order #$ORDER13_ID (completed)"

ORDER14_ID=1014
create_hpos_order $ORDER14_ID "wc-cancelled" $CUST4_ID "carlos.souza@bol.com.br" 3500.00
create_billing_address $ORDER14_ID "Carlos" "Souza" "Rua Sete de Setembro" "Curitiba" "PR" "80020-010" "carlos.souza@bol.com.br" "(41) 96543-2109"
create_order_meta $ORDER14_ID "789" "Centro" "(41) 96543-2109" "789.123.456-00"
create_order_item $ORDER14_ID "Formação Full-stack Developer" $PROD8_ID 1 3500.00
echo "Created order #$ORDER14_ID (cancelled)"

ORDER15_ID=1015
create_hpos_order $ORDER15_ID "wc-completed" $CUST5_ID "fernanda.costa@gmail.com" 0.00
create_billing_address $ORDER15_ID "Fernanda" "Costa" "Rua Oscar Freire" "São Paulo" "SP" "01426-001" "fernanda.costa@gmail.com" "(11) 95432-1098"
create_order_meta $ORDER15_ID "321" "Jardins" "(11) 95432-1098" "321.654.987-00"
create_order_item $ORDER15_ID "Curso Degustação - Introdução" $PROD9_ID 1 0.00
echo "Created order #$ORDER15_ID (completed)"

echo "=== Setting up pages... ==="
wp wc tool run install_pages --user=1 --allow-root

echo "=== Verifying data... ==="
echo "HPOS enabled:"
wp option get woocommerce_custom_orders_table_enabled --allow-root
echo ""
echo "Orders count:"
wp db query "SELECT COUNT(*) as total FROM wp_wc_orders" --allow-root
echo ""
echo "Orders by status:"
wp db query "SELECT status, COUNT(*) as count FROM wp_wc_orders GROUP BY status" --allow-root
echo ""
echo "Products count:"
wp wc product list --field=id --user=1 --allow-root | wc -l
echo ""
echo "Customers count:"
wp user list --role=customer --field=ID --allow-root | wc -l

echo "=== Creating database dump... ==="
mysqldump -h"$DB_HOST" -P"$DB_PORT" -u"$DB_USER" -p"$DB_PASSWORD" --skip-ssl "$DB_NAME" > /app/tests/_data/dump.sql
echo "Database dump created at tests/_data/dump.sql"

echo ""
echo "=== Setup Complete! ==="
echo "WordPress URL: $WP_URL"
echo "Admin Panel: $WP_URL/wp-admin"
echo "Admin User: $ADMIN_USER"
echo "Admin Password: $ADMIN_PASSWORD"
echo ""
echo "=== Data Summary ==="
echo "Products: 9 (5 extensões, 3 formações, 1 gratuito)"
echo "Customers: 10 Brazilian customers"
echo "Orders: 15 HPOS orders (varied statuses)"
echo "HPOS: Enabled"
echo ""
echo "Database dump saved to tests/_data/dump.sql"
