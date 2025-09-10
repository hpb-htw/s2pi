build:
	doxygen doxygen.conf
	rsync -a --delete --progress tmp/html/ s2pi-doc --exclude .git

clean:
	rm -rf tmp/

deploy:
	git -C s2pi-doc commit -a -m "auto commit"
	git -C s2pi-doc push origin master

