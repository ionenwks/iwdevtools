#!/usr/bin/env bash
declare -a array1
array1[0]='$(echo first)'
array1[1]="'second'"
array1[2]="the third"
declare -a array2=(a b c)

declare -A assoc1
assoc1[a]='"first"'
assoc1[b]='`echo second`'
assoc1[c]="the third"
declare -A assoc2=()

var1="\"'first "
var2=second:$(cat <<<"shouldn't be there in PATH='' rbash")
$(type -P /bin/true /usr/bin/true) && var3="shouldn't be set in rbash"

var4="${env1} ${env2}"

var5=
declare -n _shellparse_importref=var5

printf "%s\n" "${var2}" "${var3}" "${var4}"

func1() {
	echo "hello world"
}
func2() { :; }

func1

unset() { :; }
declare() { :; }
compgen() { :; }

{ syntax error
