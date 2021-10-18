#!/bin/sh
skip=44

tab='	'
nl='
'
IFS=" $tab$nl"

umask=`umask`
umask 77

gztmpdir=
trap 'res=$?
  test -n "$gztmpdir" && rm -fr "$gztmpdir"
  (exit $res); exit $res
' 0 1 2 3 5 10 13 15

if type mktemp >/dev/null 2>&1; then
  gztmpdir=`mktemp -dt`
else
  gztmpdir=/tmp/gztmp$$; mkdir $gztmpdir
fi || { (exit 127); exit 127; }

gztmp=$gztmpdir/$0
case $0 in
-* | */*'
') mkdir -p "$gztmp" && rm -r "$gztmp";;
*/*) gztmp=$gztmpdir/`basename "$0"`;;
esac || { (exit 127); exit 127; }

case `echo X | tail -n +1 2>/dev/null` in
X) tail_n=-n;;
*) tail_n=;;
esac
if tail $tail_n +$skip <"$0" | gzip -cd > "$gztmp"; then
  umask $umask
  chmod 700 "$gztmp"
  (sleep 5; rm -fr "$gztmpdir") 2>/dev/null &
  "$gztmp" ${1+"$@"}; res=$?
else
  echo >&2 "Cannot decompress $0"
  (exit 127); res=127
fi; exit $res
�)�laVASPUeff1.0.sh ��sڸ�w�û���`s�ͤ13$uR��hӹ�I0�-���Ҕ�����`�����:m�%y���/�D���|���e�M��_����Rak��qw���{�iφv�+�N{R��:�c���V�x.�v8�/5�FE�+R��2Zkw�3l�<�z8;m����Z�
gd�������e���<�����a��}xdȺB�;XO��ȫ]��ҭ���
��2p\��	%�)�Y0��{�ٻ�o-�:�q9a
o��3�"��"ɋ��Z��r���~k�x��}�Fa�R��]&hZ���<:����=�=}t]O��̑�>(<�$=ٖo�����=kԛ��q��f��r<��Ӂ7��ZQ�mמZ��;�@��C1��C��� �z���~@s%_	��`�`�} N�^2�N���x�p���Ɠ���8S?(�a[UͿ�����7���*�Pr�����%m��=@1�fO���kz��3�R	���;7�
��/P�]�ɓ	�i":� �\�s� B)L�{(�c�S�TS-�K7T��Á���N�N�AJ�h�N;�7~tpm��N^����~�n�>�<ٕ�]��/��nT�3`�f�<Y�<r�H<7�z��A"�@��I��
7�p�H�?�`[�BY*���׷������;�.rp2�Ȃ���R�����.�7p�S���Y��ƲU��D��ҳ����%�ߵ;f�8��(D��s�ШK���ё���s��n��s�"���:�m`�Y�e�R�~�<m����A�ch�tҬ_4����^��,��x�E^����O/���A�-���эT����͈H�G� ~�,sjٸ&!\MF��!�j�*����}6�4�J6�$��2�1�ua�&S@�J�l*-B��l�o��.*�;_a�7��V����D���bE���gk4#qO��e��]I�<N�ʢ���i�,��#��ZBϓ$�PIԔ�]髪�0�~J���\]�ͦ�!����M��w�H�[��ybŒ��#(G�M>����B�:�os�߆�x�o��@Ѿ��|� ����ߊ�|��`;�-�a���JrP��ch/�}�x˱��pvv�ea����ȣ,1��j�[ЛI�_B?�{�ĩ��@<r��&ǐ����L��1�F�r�c���ס�^�ȁ���|�ǡ-7��N��k�|	CK%�c��X`_VԪ��}��<:!�cP� ���i3kb�-Ԭ+K��#�m�;4���YU���ޅJ�%�;m��9~�M�9`��'
Q�D�/aE��6'N.�o���SQ�]L�%����t�&��T~��1N~�:䌓���^��|����y�xK80��ز\���/�A^���_KYZ�P`��l+��Wh�?
�)�<-:+���FZ�P^�E)sk��~"K�?5EI��Tmެ��Wh�7�����q�~���|�Y���Ii��|��B]c2�t:Fu�P*��S�q��������7|'��4��2}_��P�|9M�c��yS��wӹ���
����Ī)��&��k�w2YX�'U�����X�b�GS��@OQ9Be@%�>z��W�L8�X��1VFhU�GV�)�=Cҩ��	t����i�j�2�-%(�� �Ă_�ɖNr���Kw9�X'���R�S�k�l���L�x�;�z�x�Tu���a��mZ��Zx���J�x��3<���!`Uݠǥ;��2�[l��{yksN�p�����C��D�>!������b�ݬ_̗BI�1��DY�86E,A�������f}M�.��E����4��D(y�C�V������W��$l��6_�ϏM�k�L� �5���@V`�?i����;x��ţB=�h���,����/Hb�}�1��]=�nb�� �9L�%����dA[h��_R(\��d�ѣc����'Sa$����kD�����%��%or�����[/�m��I�SС*B�Pob�w9u7��D��J@d�|;%��#%������ù�!�=��69���ؾ$��ُj
Og5y�jH���,~�/�焩ʼ'Fie7lE������!ˉݴ��IuC�b��O<�PUU��8��Y�ul �(������Hlg�> [����
����J��9��GwC�f�k>����'���G��T�?j ���Kw=7���=H�3I�QZ�=I����J�,e`D�NڈLT	r��9�*�wޝ�`�c�0��Db��Ǯ�h⏯�E�)���6�yf��J�����n6��d��C��s�����ڼ�ɠ7wwf��+%�L�*������Ju����g����]A2�&���U�
a(�M��M�1��6x�+'��AJ�9s��Ƀ�:�h$�LFО�55�_O�	($��Cn~ʁX#�̲e8�v�C�����I�Br��2���:sE��M�7�����**.��R)��y!y��.`��b�F[��͂�ӽ�t�s�chH�-�<i�䬋E��2����/1�0�&�<�Z�!�T���>��>.�R�r����z���ORR`�7B��h�>��/���r!��,�f��$Y�X�����N��~�7}-nz"n/͓N��Mhe�g�l���n�-�S�_�b��a� ����t���Ȗ(�h�.��m�����y�h�뻼]kau�-^t�h�M�J������^afpB��T�k
��Wq��E$Ķ��-T�_Ӻt�����J����O�yf�C��}�S�]�Zm!��. ��cƞ�"�o$D=+��'p�+n��aC  