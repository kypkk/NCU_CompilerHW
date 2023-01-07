for i in {1..2}
do
echo "---test 01_$i---"
./smli < test_data/01_$i.lsp
# echo "---test 01_$i hidden---"
# ./smli < test_data/01_hidden_$i.lsp
echo "---test 02_$i---"
./smli < test_data/02_$i.lsp
# echo "---test 02_$i hidden---"
# ./smli < test_data/02_hidden_$i.lsp
echo "---test 03_$i---"
./smli < test_data/03_$i.lsp
# echo "---test 03_$i hidden---"
# ./smli < test_data/03_hidden_$i.lsp
echo "---test 04_$i---"
./smli < test_data/04_$i.lsp
# echo "---test 04_$i hidden---"
# ./smli < test_data/04_hidden_$i.lsp
echo "---test 05_$i---"
./smli < test_data/05_$i.lsp
# echo "---test 05_$i hidden---"
# ./smli < test_data/05_hidden_$i.lsp
echo "---test 06_$i---"
./smli < test_data/06_$i.lsp
# echo "---test 06_$i hidden---"
# ./smli < test_data/06_hidden_$i.lsp

echo " "
done