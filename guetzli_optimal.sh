#!/bin/bash
# 遍历文件夹下所有jpg文件
# 利用guetzli进行压缩
# ./guetzli_optimal.sh [quality] [folder/file]
hasOp=0;
start(){
	case $# in
		0 ) echo "Error params for function start"
			return
		;;
		1 )
			traversal $1 
		;;
		2 )
			traversal $2;
		;;
	esac
}

# 遍历folder
traversal(){
	echo 'hasOp:' $hasOp
	echo 'in traversal'
	if [[ -f $1 ]]; then
		#statements
		optimal $1
	elif [[ -d $1 ]]; then
		#statements
		for file in $1*; do
			#statements
			if [[ -f $file ]]; then
				#statements
				optimal $file
			elif [[ -d $file ]]; then
				#statements
				traversal $file
			fi
		done
		echo 'done!!!!'
	fi
}

optimal(){
	echo 'In optimal:' $1
	path=$1;
	if [[ "${path##*.}" = "jpg" ]]; then
		#statements
		echo "type:" "${path##*.}"
		case $hasOp in
			0 )
				`guetzli $1 $1`
				;;
			1 )
				`guetzli -quality $quality $1 $1`
				;;
		esac
	fi
}

echo $#
case $# in
	0 ) 
		echo './guetzli_optimal.sh [quality default 95] [folder/file]'
		return
	;;
	1 ) 
		path=$1
		start $1
	;;
	2 ) 
		hasOp=1
		quality=$1
		path=$2
		start $1 $2
	;;
esac