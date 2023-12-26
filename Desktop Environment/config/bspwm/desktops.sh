for m in $(bspc query -M --names); do
	bspc monitor "$m" -d $(for i in {01..10}; do
		# echo "$(echo "$m" | cut -d'-' -f 1)_$i"
		echo "$m"_"$i"
	done)
done
