CREATE TABLE access_event
  (
    timestmp          BIGINT NOT NULL,
    requestURI        VARCHAR(254),
    requestURL        VARCHAR(254),
    remoteHost        VARCHAR(254),
    remoteUser        VARCHAR(254),
    remoteAddr        VARCHAR(254),
    protocol          VARCHAR(254),
    method            VARCHAR(254),
    serverName        VARCHAR(254),
    postContent       VARCHAR(254),
    event_id          INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1)
  );

CREATE TABLE access_event_header
  (
    event_id	      INTEGER NOT NULL,
    header_key        VARCHAR(254) NOT NULL,
    header_value      VARCHAR(1024),
    PRIMARY KEY(event_id, header_key)
  );
