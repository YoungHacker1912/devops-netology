5.По умолчанию выделено 1Гб оперативки и 2ЦПУ

6.Чтобы изменить конфигурацию, нужно прописать в Vagrantfile строки vb.memory и vb.cpus, например:

  config.vm.provider "virtualbox" do |vb|
  vb.memory = 2048
  vb.cpus = 3
  end
  
 После сделать vagrant reload
  
8.HISTSIZE строка 851
Cпособ сохранения команд в списке истории. Если список значений включает ignorespace, строки, начинающиеся с пробела, не сохраняются в истории список. Значение ignoredups приводит к тому, что строки, соответствующие предыдущей записи истории, не сохраняются. ignoreboth является сокращением для ignorespace и ignoredups.

9.case  coproc  do done elif else esac fi for function if строка 179

10.100000 файлов можно создать, например, командой touch file{0..100000}, но 300000 для touch слишком большое число, выдает ошибку -bash: /usr/bin/touch: Argument list too long

11.[[ -d /tmp ]] проверяет /tmp это директория или нет, для проверки можно написать простой скриптик script.sh

if [[ -d /script.sh ]]; then
        echo "It is a directory"
else
        echo "It is a file"
fi
#output будет "It is a file"

12.mkdir /tmp/new_path_directory/bash
cp /bin/bash /tmp/new_path_directory/bash
PATH=$PATH:/tmp/new_path_directory/bash

13.Команда at используется для назначения одноразового задания на заданное время, а команда batch — для назначения одноразовых задач по расписанию





