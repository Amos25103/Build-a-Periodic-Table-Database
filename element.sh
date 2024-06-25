
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
ARG=$1

if [ -z "$ARG" ]; then
  echo "Please provide an element as an argument."
else

if ! [[ $ARG =~ ^[0-9]+$ ]]; then
  if [[ $(expr length "$ARG") -gt 2 ]]; then
    # get by full name
    DATA=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE name='$ARG'")
    if [[ -z $DATA ]]; then
      echo "I could not find that element in the database."
    else
      #Display data
      echo "$DATA" | while IFS='|' read TYPEID NUMBER SYMBOL NAME MASS MELTING BOILING TYPE
      do
        echo "The element with atomic number $NUMBER is $ARG ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $ARG has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
      done
    fi
  else
    # get by atomic symbol
    DATA=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol='$ARG'")
    if [[ -z $DATA ]]; then
      echo "I could not find that element in the database."
    else
      #Display data
      echo "$DATA" | while IFS='|' read TYPEID NUMBER SYMBOL NAME MASS MELTING BOILING TYPE
      do  
        echo "The element with atomic number $NUMBER is $NAME ($ARG). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
      done
    fi
  fi
else
  # get by atomic number
  DATA=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number=$ARG")
  if [[ -z $DATA ]]; then
      echo "I could not find that element in the database."
  else
    echo "$DATA" | while IFS='|' read TYPEID NUMBER SYMBOL NAME MASS MELTING BOILING TYPE
    do
      echo "The element with atomic number $ARG is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
    done
    fi
fi







fi

