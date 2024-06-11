#!/usr/bin/python3
""" Module for testing console"""
import unittest
from unittest.mock import patch
from io import StringIO
from console import HBNBCommand
from models.__init__ import storage


class test_console(unittest.TestCase):
    def setUp(self):
        self.cmd_obj = HBNBCommand()

    @patch('sys.stdout', new_callable=StringIO)
    def test_do_create(self, mock_stdout):
        test_cmd = 'create State name="Arizona_L" post="0000" pop=9080 gdp=4.5'
        self.cmd_obj.onecmd(test_cmd)
        result = mock_stdout.getvalue()
        result = result.replace('\n', '')
        print(result)
        obj = storage.all()["State.{}".format(result)]
        self.assertIsNotNone(obj)
