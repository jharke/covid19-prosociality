.PHONY: clean clean_py clean_backup clean_otree reset_db validate_html create_checksum checksum blocklist prolific_copy_internal_name payment prolific_copy_payment get_sql_backup diff_do_files_dropbox update_covid19_cases

venv=~/.virtualenvs/otree_TEMP_38_2/bin
venv_analysis=~/.virtualenvs/2020_corona_donation_experiment/bin
prolific_date=$(shell date +%d.%m.%Y)
last_session=$(shell cd ./prolific/ && /usr/bin/ls | grep -o '[[:digit:]]*' | sort | tail -1)
sql_backup='/run/user/1001/gvfs/sftp:host=pasithea/wzb/samba/user/harke/corona_sql_backup/'

reset_db:
	OTREE_SECRET_KEY=temp $(venv)/otree resetdb --noinput
	rm db.sqlite3

clean_py:
	find . -type f -name "*.py[co]" -delete
	find . -type d -name "__pycache__" -delete

clean_backup:
	find . -type f -name "*~" -delete

clean_otree: reset_db
	find . -type f -name "__temp_migrations" -delete

clean: clean_otree clean_backup clean_py

validate_html:
	find . -name '*.html' -type f -print -exec tidy -utf8 -e -q --show-body-only yes '{}' \;

create_checksum:
	@cd ./results/raw/ && sha256sum *.csv > SHA256SUMS

checksum:
	@cd ./results/raw/ && sha256sum -c SHA256SUMS

blocklist:
	@echo 'Last session:' $(last_session)
	@cd ./prolific/ && /usr/bin/ls | grep -o '[[:digit:]]*' | sort | tail -1
	$(venv_analysis)/python prolific/get_blocklist.py

prolific_copy_internal_name:
	@echo $(prolific_date) full rollout $(last_session) | xsel -i -b

payment:
	$(venv_analysis)/python prolific/payment_process.py

prolific_copy_blocklist:
	@wc -l './prolific/session'$$(($(last_session)-1))'/blocklist_session'$$(($(last_session)-1))'.txt'
	@wc -l './prolific/session'$(last_session)'/blocklist_session'$(last_session)'.txt'
	@echo 'Blocklist copied'
	@cat './prolific/session'$(last_session)'/blocklist_session'$(last_session)'.txt' | xsel -i -b

prolific_copy_payment:
	@echo 'Prolific participation fee copied: '$$(wc -l './prolific/session'$(last_session)'/payment_session'$(last_session)'_participation_fee.csv' | awk '{ print $$1 }')
	@cat './prolific/session'$(last_session)'/payment_session'$(last_session)'_participation_fee.csv' | xsel -i -b
	@read -p 'Continue...'
	@echo 'Prolific bonus copied: '$$(wc -l './prolific/session'$(last_session)'/payment_session'$(last_session)'_bonus.csv' | awk '{ print $$1 }')
	@cat './prolific/session'$(last_session)'/payment_session'$(last_session)'_bonus.csv' | xsel -i -b

get_sql_backup:
	@read -p 'Session: ' covid19_exp_session && ssh TU-experiment 'cd ~/Julian/corona_sql_backup/ && pg_dump postgres://postgres:mydbpassword@localhost/Julian_corona_session'$$covid19_exp_session' > Julian_corona_session'$$covid19_exp_session'.bak'
	test -r $(sql_backup)/SHA256SUMS
	rsync -aP 'TU-experiment:/home/experimenter/Julian/corona_sql_backup/' $(sql_backup)

diff_do_files_dropbox:
	@cd ./results/stata/do-files/ && for i in *.do; do \
		echo $$i && \
		diff $$i ~/Dropbox/covid19_donation_experiment/do-files/$$i || exit 1; \
	done
	@echo 'No difference between git repo and dropbox folder.'

update_covid19_cases:
	PYTHONPATH=./ $(venv_analysis)/python results/python/update_covid_data.py
