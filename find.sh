usage() { echo "Usage: $0 [-f folder] [-w word]" 1>&2; exit 1; }

while getopts "f:w:" o; do
    case "$o" in
        f)
            s="$OPTARG"
                if [ ! -d "$OPTARG" ] ; then
                    echo "ERROR: $OPTARG should be a directory.";
                    usage
                fi
            ;;
        w)
            c="$OPTARG"
            if [ -z "$OPTARG" ] ; then
    			echo "ERROR: input -w empty"
    			usage
			fi
            ;;
        *)
            usage
            ;;
    esac
done
shift "$((OPTIND-1))"

if [ -z "$s" ] ; then
    echo "ERROR: input -f empty"
    usage
fi
if [ -z "$c" ] ; then
    echo "ERROR: input -w empty"
    usage
fi

if [ ! -d $PWD"/find_result" ] ; then
    mkdir find_result
fi

if [ ! -f $PWD"/logs.txt" ] ; then
    touch $PWD"/logs.txt"
    chmod 777 $PWD"/logs.txt"
fi

echo "---------------------Execution started:" $(date -u) "-----------------" >> $PWD"/logs.txt"

chmod 777 $PWD"/find_result"
COUNTER=0
for entry in "$s"/*
    do
        chmod 777 "$entry" >> $PWD"/logs.txt"
        COUNTER=$((COUNTER + 1)) >> $PWD"/logs.txt"
        touch $PWD"/find_result/file${COUNTER}.txt" >> $PWD"/logs.txt"
        chmod 777 $PWD"/find_result/file${COUNTER}.txt" >> $PWD"/logs.txt"
        pdftotext "$entry" $PWD"/find_result/file${COUNTER}.txt" >> $PWD"/logs.txt"
    done

python3 find_python.py "$c"