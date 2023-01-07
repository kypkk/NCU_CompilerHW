for i in {1..2}
do
echo "---test 01---"
./smli < public_test_data/01_$i.lsp
echo "---test 02---"
./smli < public_test_data/02_$i.lsp
echo "---test 03---"
./smli < public_test_data/03_$i.lsp
echo "---test 04---"
./smli < public_test_data/04_$i.lsp
echo "---test 05---"
./smli < public_test_data/05_$i.lsp
echo "---test 06---"
./smli < public_test_data/06_$i.lsp
echo "---test 07---"
./smli < public_test_data/07_$i.lsp
echo "---test 08---"
./smli < public_test_data/08_$i.lsp
echo " "
done