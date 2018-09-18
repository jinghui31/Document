from argparse import ArgumentParser
from datetime import datetime

parser = ArgumentParser(description = 'producer program')
parser.add_argument('new', metavar = 'New Sensor', nargs = '?', help = 'The person to whom you want to say hello')
parser.add_argument('-s', '--sum', dest = 'verbose', action = 'store_true', help = 'Increase output verbosity')
args = parser.parse_args()

print 'Hello, %s!' % args.new
if args.verbose:
    print datetime.now().isoformat()

ap = argparse.ArgumentParser()
ap.add_argument("-d", "--dataset", required=True,
	help="path to input dataset")
ap.add_argument("-k", "--neighbors", type=int, default=1,
	help="# of nearest neighbors for classification")
ap.add_argument("-j", "--jobs", type=int, default=-1,
	help="# of jobs for k-NN distance (-1 uses all available cores)")
args = vars(ap.parse_args())