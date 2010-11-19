all: clear unit acceptance

acceptance: clear functional javascript

simple: clear unit functional

clear:
	@clear

unit:
	@echo ""
	@echo "========================"
	@echo "Rodando testes unitários"
	@echo "========================"
	@echo ""
	@rake spec

functional:
	@echo ""
	@echo "========================="
	@echo "Rodando testes funcionais"
	@echo "========================="
	@echo ""
	@cucumber features --tag ~@javascript --format progress

javascript:
	@echo ""
	@echo "============================"
	@echo "Rodando testes de javascript"
	@echo "============================"
	@echo ""
	@cucumber features --tag @javascript --format progress

