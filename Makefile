all: build

build:
	@printf "Launching dinit-user.sh script\n"
	@./dinit-user.sh build
	@printf "Done\n"

install:
	@printf "Launching dinit-user.sh script\n"
	@./dinit-user.sh install
	@printf "Done\n"

uninstall:
	@printf "Launching dinit-user.sh script\n"
	@./dinit-user.sh uninstall
	@printf "Done\n"

clean:
	rm -rf work/
	@printf "Done\n"