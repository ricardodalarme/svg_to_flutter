import 'dart:async';
import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:io/io.dart';

import './commands/svg_to_flutter_command.dart';
import './exception.dart';

/// Commander Runner for Camus Iconfont
class SvgToFlutterCommandRunner extends CommandRunner<int> {
  /// constructor
  SvgToFlutterCommandRunner()
      : super(
          'svg_to_flutter',
          'generate your font files & Flutter Icons',
        ) {
    addCommand(SvgToFlutterCommand());
  }

  @override
  Future<int> run(Iterable<String> args) async {
    try {
      final ArgResults argResults = parse(args);
      final int exitCode =
          await runCommand(argResults) ?? ExitCode.success.code;
      return exitCode;
    } on SvgToFlutterException catch (e) {
      stderr.writeln('\x1b[31m ❌ $e ❌');
      return ExitCode.usage.code;
    } on SvgToFlutterUsageException catch (e) {
      stderr.writeln('\x1b[31m ❌ $e ❌');
      return ExitCode.usage.code;
    } on UsageException catch (e) {
      stderr.writeln('\x1b[31m ❌ $e ❌');
      return ExitCode.usage.code;
    } on Exception catch (e) {
      stderr.writeln('\x1b[31m ❌ $e ❌');
      return ExitCode.usage.code;
    }
  }
}
