# https://en.wikipedia.org/wiki/ANSI_escape_code
declare -A ESC_S;
# ESCape Sequences
ESC_S=(
    ["CSI"]="\033[" # Control Sequence Introducer
)
# Select Graphic Rendition
# $1 SGR_P()
function SGR () {
    echo "${ESC_S['CSI']}$1m"
}
function SGR_RESET () {
    echo `SGR 0` # \033[0m
}
# SGR Parameters
# 引数を;区切にする
# $1..$9 = 0..107  https://en.wikipedia.org/wiki/ANSI_escape_code
function SGR_P () {
    for x in "$@"
    do
        local ret="$ret$x;"
    done
    local ret=`echo $ret | sed -e 's/;$//'`
    echo $ret
}

# 以下、使用例（コメントアウト）
<< "#__CO__"
function Program () {
    for x in $(seq 30 38) ; do
        local ansi=`SGR $(SGR_P 01 $x)`
        echo -n -e "$ansi$x "
    done
    echo 
    for x in $(seq 40 48) 0 ; do
        local ansi=`SGR $(SGR_P 01 $x)`
        echo -n -e "$ansi$x "
    done
    echo 
}
Program
#__CO__

