COMPONENT=TestADE7753AppC
BUILD_EXTRA_DEPS = TestADE7753Msg.py TestADE7753Msg.class
CLEAN_EXTRA = TestADE7753Msg.py TestADE7753Msg.class TestADE7753Msg.java

TestADE7753Msg.py: TestADE7753.h
	mig python -target=$(PLATFORM) $(CFLAGS) -python-classname=TestADE7753Msg TestADE7753.h testade7753_msg -o $@

TestADE7753Msg.class: TestADE7753Msg.java
	javac TestADE7753Msg.java

TestADE7753Msg.java: TestADE7753.h
	mig java -target=$(PLATFORM) $(CFLAGS) -java-classname=TestADE7753Msg TestADE7753.h testade7753_msg -o $@

CFLAGS += -I$(TOSDIR)/chips/ade7753
CFLAGS += -DTOSH_DATA_LENGTH=100


include $(MAKERULES)

