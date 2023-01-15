for m in $(bspc query -M); do
	bspc monitor "$m" -d $(for i in {01..10}; do
		echo "$(bspc query -M -m "$m" --names | cut -d'-' -f 1)_$i"
	done)
done
