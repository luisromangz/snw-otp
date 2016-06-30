FROM opentripplanner/opentripplanner
COPY graph /var/otp/graphs/graph
CMD ["--router", "graph", "--server", "--analyst"]
