MAIN            := tokenizer.s
LIBS		:= libio.s libstring.s
SRCS            := $(MAIN) $(LIBS)
JAVA		:= java
MARS		:= ../../Mars4_5.jar
MARSFLAGS	:= sm p
ARGS		:= "Grammar is a system of rules which governs the production and use of utterances in a given language. These rules apply to sound as well as meaning, and include componential subsets of rules, such as those pertaining to phonology (the organisation of phonetic sound systems), morphology (the formation and composition of words), and syntax (the formation and composition of phrases and sentences). Many modern theories that deal with the principles of grammar are based on Noam Chomsky's framework of generative linguistics."

run:	$(SRCS)
	@$(JAVA) -jar $(MARS) $(MARSFLAGS) $(MAIN) pa $(ARGS)

